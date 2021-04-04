// +build production

package service

import (
	"context"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/metrics"
)

// metricServiceServer is implementation of proto.metricServiceServer proto interface
type metricServiceServer struct {
}

var metricsChan chan *proto.MetricUpdates

func NewMetricServiceServer(c chan *proto.MetricUpdates) proto.MetricServiceServer {
	metricsChan = c
	return &metricServiceServer{}
}

func (s *metricServiceServer) GetAll(ctx context.Context, e *proto.Empty) (*proto.MetricUpdates, error) {
	metrics, err := metrics.ReadAll()
	if err != nil {
		return nil, err
	}
	var updates []*proto.MetricUpdate
	for _, m := range metrics {
		updates = append(updates, &proto.MetricUpdate{Name: m.Name, Value: m.Value, Target: float64(m.Target)})
	}
	return &proto.MetricUpdates{Updates: updates}, nil
}

func (s *metricServiceServer) Subscribe(e *proto.Empty, stream proto.MetricService_SubscribeServer) error {
	log.Print("Metrics Subscribe requested")
	for {
		m := <-metricsChan
		// metrics.Put(context.Background(), m)
		if err :=
			stream.Send(&proto.MetricUpdates{Updates: m.Updates}); err != nil {
			// put message back to the channel
			metricsChan <- m
			log.Printf("Stream connection failed: %v", err)
			return nil
		}
	}
}

func (s *metricServiceServer) ReadConfig(ctx context.Context, e *proto.Empty) (*proto.MetricConfigs, error) {
	ms, err := metrics.ReadAll()
	if err != nil {
		return nil, err
	}
	var configs []*proto.MetricConfig
	for _, m := range ms {
		configs = append(configs, metrics.ToProto(&m))
	}
	return &proto.MetricConfigs{Configs: configs}, nil
}

func (s *metricServiceServer) UpdateConfig(ctx context.Context, e *proto.MetricConfigs) (*proto.Empty, error) {
	for _, c := range e.Configs {
		err := metrics.Update(metrics.ToMetric(c))
		if err != nil {
			return nil, err
		}
	}
	return nil, nil
}
