Return-Path: <linux-fpga+bounces-690-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5CA96480D
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Aug 2024 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376C2B28519
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Aug 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04EC1B3F0F;
	Thu, 29 Aug 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELZn2oHk"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8E1B3732
	for <linux-fpga@vger.kernel.org>; Thu, 29 Aug 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941141; cv=none; b=AXijs002tHPIQLT91M0DR1MNeXRzq2etZ+GMgQOn3P85QGEUJuPPVY/dQKVh6EsVGH/caNmZHKbVkhgO9rSNGzxn2DKRsJy6/XyUMc9elPd7XrYMd97YRqzl6HnQtUMICwlM4AEUUR9Dkb51YYSqRohkXM4ElWzUbFJsHR3BuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941141; c=relaxed/simple;
	bh=nzy04PgDjxRp4clOpzx7ZwAQtwC8BOnrH0UdBVVoGHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyPuWUzBNtRHCI0J147eycmfZpPlk2bdjtzB4zry1Ju9UBOeByiYpZAizWhIlwXbg+pHj25TWDx6NArEyOk6Qa9GUX4odjjYnZi4AOF52dvIQyd5sXJIMJWbJ4U1ZtqLAbNEQkvHfxE/r/1dWj2yZ67Wknej6WVI9esCXWpg+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELZn2oHk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osuRWDMAcWp5GKuvb2jQp7XxiFBFhqIKDkkqm4u4oTc=;
	b=ELZn2oHkwFpBO06izRWY/dmYlxh11Gnowgq4+iJ1tP7NpNoy19z13508x1uICYiwK+5Fcu
	Cd7j7tYtS08FdEVXBrXVo5lZ5IVlaYvVPfuUb8WeLVjPr79MnbuT/qu14oNLxELUtCoyLd
	uMATzfdhuwG4fMrKtOzBG/Ir7KLXU6M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-r6eRiJXMMI2_BpeBUcbeJg-1; Thu, 29 Aug 2024 10:18:57 -0400
X-MC-Unique: r6eRiJXMMI2_BpeBUcbeJg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3718d9d9267so580280f8f.0
        for <linux-fpga@vger.kernel.org>; Thu, 29 Aug 2024 07:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941136; x=1725545936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osuRWDMAcWp5GKuvb2jQp7XxiFBFhqIKDkkqm4u4oTc=;
        b=jerpuASVlghFi7+2XL3TWFnsqcyUagLoSiMxagA8chPhnI+JuCwWZ+i0iWi+nU9qgw
         GsBMuvMTUKg9TTqRmV76fN76kP4dOLsuFZPuz7oxI1moqnCDMcOp5hFVuUEgcMAbv+NV
         VFZlFm/nq2WmOYcm/8NURfDQyZRJ9uFcw/3NVGvWJBSJlL1d9eNOwxp+LhJTfwwCZC8W
         QoYvjBlhikONH38pN7x/A6JuQUD4wy2NoWIeDlSW6sporBZYZKljdDSC9R+X2aD3NiWW
         D0O9MFFO9xgwLM6R0O5CU6VNbKGK8JV5ILxhIOkOHSjZEeuQ+GrNK/t0EWddMHJz5aJi
         T/lA==
X-Forwarded-Encrypted: i=1; AJvYcCVNTxSwbovcxjapxLYKK0ZHJwJXOsJ3gsOVx7wboNPVCzD8cyILy4u61F5ofHmX3dVaXDHvfV5x8l/I@vger.kernel.org
X-Gm-Message-State: AOJu0YwP7z7wgr52Zf3aWjcC/tPM08EpsHmPFnAi7QzEBZp6SOhs1mJg
	T/eYXpL64N+gGUbRUUjm2zkFHH3qmy78HFzwRE7kgS+H2Kfdx+97npmgcR1/u2dCpf7ORLNw8xo
	lXAjGICeRdblv24hFjHBFsgvLIPZL4eNB7lnTR1dNnHHjyYOMytfzxip1Qek=
X-Received: by 2002:adf:f24c:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-3749b5503f3mr2024870f8f.28.1724941136554;
        Thu, 29 Aug 2024 07:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYRK3DCkIWLqUxz0XY2NMNmO7BWhVLf+DW2Gbx1uLqQ4PTQOElvgJY4ok5jVfTKZaAWaobsQ==
X-Received: by 2002:adf:f24c:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-3749b5503f3mr2024838f8f.28.1724941136092;
        Thu, 29 Aug 2024 07:18:56 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:55 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v5 5/7] ethernet: cavium: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:24 +0200
Message-ID: <20240829141844.39064-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829141844.39064-1-pstanner@redhat.com>
References: <20240829141844.39064-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Furthermore, the driver contains an unneeded call to
pcim_iounmap_regions() in its probe() function's error unwind path.

Replace the deprecated PCI functions with pcim_iomap_region().

Remove the unnecessary call to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..984f0dd7b62e 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,12 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	err = PTR_ERR_OR_ZERO(clock->reg_base);
 	if (err)
 		goto error_free;
 
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
-
 	spin_lock_init(&clock->spin_lock);
 
 	cc = &clock->cycle_counter;
@@ -292,7 +291,7 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
+	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0


