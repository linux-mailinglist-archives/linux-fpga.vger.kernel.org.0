Return-Path: <linux-fpga+bounces-24-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC17F48FD
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Nov 2023 15:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFC62815B4
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Nov 2023 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF304D5AB;
	Wed, 22 Nov 2023 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk1ilWA5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59781AC
	for <linux-fpga@vger.kernel.org>; Wed, 22 Nov 2023 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700663581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=if0lTIQhFuWRokgwIBfp5g8FVKKy/4t3RxOoc3DJYVs=;
	b=gk1ilWA5LbM9XhSDOKnA/LEwYStHGxY18hT3mHTEUwYjfl4WbFxAFqYYyQUPOEQmH1wlLx
	ftk/s1dtzi0fAKFVdMNLd7B7izA2z69onAKjz90U/xLdmIcRrOJWATduixkn15Hfc2G61Y
	dKx43slSZEmdH+BgpNYQBhVPxlECojk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-TiF3zzp9NwuNDelMOC5yog-1; Wed, 22 Nov 2023 09:32:59 -0500
X-MC-Unique: TiF3zzp9NwuNDelMOC5yog-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-421b20c9893so94838291cf.0
        for <linux-fpga@vger.kernel.org>; Wed, 22 Nov 2023 06:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663579; x=1701268379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=if0lTIQhFuWRokgwIBfp5g8FVKKy/4t3RxOoc3DJYVs=;
        b=qc5CoeuDytPdZyjoKCX1I7lsfFarw1E9mAGQEVjfNzkWIokGsknl50bw1sPswqG+uU
         ytHvFf3dOyS7NX0ErrS0ZU9Qe1CKvwKuw/5LO3x0cnE4BQ+ldZ8t4CYB8cy7zvg/Qts+
         6lTwJ/TYaepgOmzQbn/H3RE/TNrj01QwsJ4hG5waWtUoh5SJeszSk0c/e0QbOwhahj8k
         HLkeungeef2fmjoFRfLwydARHsI75JDXzk5aO2oMvPF94rSUT0Yk/0jhYLo0phFQGqEY
         MHBKspqANMGH9dGPZ7pwGBh6cIx3HIISxC4VXN6+QPzu36iWgDGHuSJZTYZwE/sL68uh
         aMXw==
X-Gm-Message-State: AOJu0Yyy2xfPnOvy5OFpzaoGnbbmAJKei1+hOHkJLbh+y83cOPP3603n
	QY9L0HezxJrRhih0iy3hQFKJmUcI2sH69Nw53tcbJNChReo18aEkdcSuRJ/BfScP0xzpWObkcHy
	BvZzGlrHhiBQpyj6WDmVY
X-Received: by 2002:a05:622a:120e:b0:421:c3a9:1e52 with SMTP id y14-20020a05622a120e00b00421c3a91e52mr2696728qtx.31.1700663579317;
        Wed, 22 Nov 2023 06:32:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxPsf924/xjwAZvoG0CEZ1YKtPUQiLpYymPo32gafiI5TVBLwkn6DBRalXtRx2dAlFoLJdYA==
X-Received: by 2002:a05:622a:120e:b0:421:c3a9:1e52 with SMTP id y14-20020a05622a120e00b00421c3a91e52mr2696697qtx.31.1700663578935;
        Wed, 22 Nov 2023 06:32:58 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id v7-20020ac87487000000b0041950c7f6d8sm4430101qtq.60.2023.11.22.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:32:58 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH 0/2] fpga: improve protection against low-level modules unloading
Date: Wed, 22 Nov 2023 15:32:50 +0100
Message-ID: <20231122143252.181680-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC proposes a possible solution to keep protecting the fpga
manager against the unexpected unloading of low-level control modules
while addressing the limitations of the current implementation. The
current implementation assumes that the low-level module registers a
platform driver for the parent device, which can later be used by the
fpga manager (through the parent device pointer) to take the low-level
module's refcount. This proposal removes this limitation by adding a
module owner field to the fpga_manager and fpga_manager_ops structs.
Low-level control modules can statically set the owner field to
THIS_MODULE. Later, the fpga manager can use the owner field to take
the module's refcount.

For more context, please refer to these threads:
https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
https://lore.kernel.org/linux-fpga/ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050

Signed-off-by: Marco Pagani <marpagan@redhat.com>

Marco Pagani (2):
  fpga: add a module owner field to fpga_manager and fpga_manager_ops
  fpga: set owner of fpga_manager_ops for existing low-level modules

 drivers/fpga/altera-cvp.c             |  1 +
 drivers/fpga/altera-pr-ip-core.c      |  1 +
 drivers/fpga/altera-ps-spi.c          |  1 +
 drivers/fpga/dfl-fme-mgr.c            |  1 +
 drivers/fpga/fpga-mgr.c               | 56 +++++++++++++++++++--------
 drivers/fpga/ice40-spi.c              |  1 +
 drivers/fpga/lattice-sysconfig.c      |  1 +
 drivers/fpga/machxo2-spi.c            |  1 +
 drivers/fpga/microchip-spi.c          |  1 +
 drivers/fpga/socfpga-a10.c            |  1 +
 drivers/fpga/socfpga.c                |  1 +
 drivers/fpga/stratix10-soc.c          |  1 +
 drivers/fpga/tests/fpga-mgr-test.c    |  1 +
 drivers/fpga/tests/fpga-region-test.c |  1 +
 drivers/fpga/ts73xx-fpga.c            |  1 +
 drivers/fpga/versal-fpga.c            |  1 +
 drivers/fpga/xilinx-spi.c             |  1 +
 drivers/fpga/zynq-fpga.c              |  1 +
 drivers/fpga/zynqmp-fpga.c            |  1 +
 include/linux/fpga/fpga-mgr.h         |  4 ++
 20 files changed, 62 insertions(+), 16 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.42.0


