package util

import (
	"context"

	"github.com/rs/xid"
)

func GetNewUUID(ctx context.Context) string {
	return xid.New().String()
}
