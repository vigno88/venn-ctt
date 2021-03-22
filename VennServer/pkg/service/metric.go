// +build production

package service

import (
	"context"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

// metricServiceServer is implementation of proto.metricServiceServer proto interface
type metricServiceServer struct {
}

var metricsChan chan *proto.Metric

func NewMetricServiceServer(c chan *proto.Metric) proto.MetricServiceServer {
	metricsChan = c
	return &metricServiceServer{}
}

// Get is used to get the current set of metrics
func (s *metricServiceServer) Get(ctx context.Context, e *proto.Empty) (*proto.Metrics, error) {
	// return metrics.GetAll(ctx)

	// Code used for testing purpose
	return &proto.Metrics{Metrics: []*proto.Metric{
		{Name: "Temperature 1", Value: 0.0, Average: 0.0},
		{Name: "Humidity 1", Value: 0.0, Average: 0.0},
		{Name: "Temperature 2", Value: 0.0, Average: 0.0},
		{Name: "Humidity 2", Value: 0.0, Average: 0.0},
	}}, nil

}

func (s *metricServiceServer) Subscribe(e *proto.Empty,
	stream proto.MetricService_SubscribeServer) error {
	log.Print("Metrics Subscribe requested")
	for {
		m := <-metricsChan
		// metrics.Put(context.Background(), m)
		if err :=
			stream.Send(&proto.Metrics{Metrics: []*proto.Metric{m}}); err != nil {
			// put message back to the channel
			metricsChan <- m
			log.Printf("Stream connection failed: %v", err)
			return nil
		}
	}
	// i := 0
	// for {
	// 	time.Sleep(500 * time.Millisecond)
	// 	m := proto.Metric{Name: "cylinder1", Value: float64(i), Average: 12.0}
	// 	if err := stream.Send(&m); err != nil {
	// 		// put message back to the channel
	// 		metricsChan <- m
	// 		log.Printf("Stream connection failed: %v", err)
	// 		return nil
	// 	}
	// 	i++
	// 	log.Printf("Metric sent: %v", m)
	// }
}

// func SendMetric(ctx context.Context, m *proto.Metric) {
// 	metrics.Put(ctx, m)
// 	metricsChan <- *m
// }
