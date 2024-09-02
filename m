Return-Path: <linux-fpga+bounces-702-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD40967F5B
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Sep 2024 08:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2F5B220D9
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Sep 2024 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F217C9E7;
	Mon,  2 Sep 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCCpQ16Q"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF017995E
	for <linux-fpga@vger.kernel.org>; Mon,  2 Sep 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258267; cv=none; b=ld4zRi3myI7rgmY6uhYpb8X2JwtJSMbMcYmbO2nVr1RApT4/pr2v5TMas4/0O4GI28iq4L/YQcS0qMo83mciNhXWgepyiTC+HHOZnMntzogARi8VqCq+2FOzU8kelkUOIE+t4bFPO18eHc8l2VqqhKyoqQo9eLJrY9965CTguEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258267; c=relaxed/simple;
	bh=V4KRcC8BfWc5Sti/Fdc73KUa8QY4uocvnp5UyVnLmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gD8yG6buIgdrStWJNRGH8n8M8nedgNzQZSNVsFtjOfRAPFJBAYpD7qh+yQI9Ym1zngmqe8cZFAd+8L7iv8LQ3cnralii8qroLEBPmmpxlkibzGg3to7YuLRBrXsBo4h1MkHf9iBePm5ya1x8PU6ZSkuUIzos588z3AHEy3XZuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCCpQ16Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725258265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
	b=dCCpQ16QFzI4MW5iO/8umxomU81/VJRGdsL9yshjxr+F/+t305uMUJFRhRJ33TRCWB/sZS
	fF6n6RVIc9+ivsAuLEn273B2EnFqZPX7177bzCQdieDV43lmr+DcvkwhJL6E8CdseqZKv3
	gqwNfVmO2avGh3S8uJ/ITYNdx+2fxjw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-NC0ZZeKxPEaq7CNsNUn9Lg-1; Mon, 02 Sep 2024 02:24:23 -0400
X-MC-Unique: NC0ZZeKxPEaq7CNsNUn9Lg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a968ad3765so145975985a.2
        for <linux-fpga@vger.kernel.org>; Sun, 01 Sep 2024 23:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725258263; x=1725863063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
        b=gdTwT8sEAXmSQLuoOBySs79pl7DPXeg3UdO3xwBLNHycepe8BIkz/rriVAsnkX89o3
         lU8Dn/qadvU56qGYFGqIFx5JTwzAHJv5t3mvD+gG2dq2Gx3Z2U4qNyf3sbZVYyuO0PKu
         Mu//Gxn7Ahf48AArqMcDhtApF/xwg4KKV/DkBabAAhyTgOcqpxmFAapz4JnHzNIzthYK
         OnqF3Ye/PPguT9B6YGTl6jiT2/CT5zzs0RKj/tYGhYlhfmcUYTu9LPbI+Vw9esIHWM9o
         4rq72rGCSSVyXie1honAByLzW8YQgRmJERbvSerTdtZl9rAmxywVBWolyfZ5QL7mTVQd
         fs1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVM9o7JwGcS/ucu79lFgWS/PeEr2pOzYHLGtvrkL2X2T5coQA+lgOKY60840qdqg+4WRyZn+RjtlXj4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GY+cBYzUnq4+lE1ZTcYIrpsHB1BLWvGCZbAIOTkXjtNNoGaM
	1QZn7rFp9s1FiGKctrG7KPNTr3NdEaHTcHaOWhN10ScWXjNC0ZO3TYWWBUW9yczZDshqzhd4pGr
	veZ6W7epfmNcTs/0SNYskvO7q6Fs6x3qQ7EGPqEwhi5chVcx0sk5LrwK70M0=
X-Received: by 2002:a05:620a:430b:b0:7a6:5c8e:10fe with SMTP id af79cd13be357-7a804266c1bmr1694476885a.53.1725258263144;
        Sun, 01 Sep 2024 23:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPpfy2AwzBVBvCGLt6NdOfcVUX9tS8CXYBUh8z9oXo7696XQ8Ic8gWj62Bu7ymXSEARN/JRQ==
X-Received: by 2002:a05:620a:430b:b0:7a6:5c8e:10fe with SMTP id af79cd13be357-7a804266c1bmr1694473785a.53.1725258262782;
        Sun, 01 Sep 2024 23:24:22 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3a34asm389211385a.84.2024.09.01.23.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 23:24:22 -0700 (PDT)
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
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 2/5] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Mon,  2 Sep 2024 08:23:39 +0200
Message-ID: <20240902062342.10446-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902062342.10446-2-pstanner@redhat.com>
References: <20240902062342.10446-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Port dfl-pci.c to the successor, pcim_iomap_region().

Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-pci.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 80cac3a5f976..602807d6afcc 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -39,14 +39,6 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
-static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
-{
-	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
-		return NULL;
-
-	return pcim_iomap_table(pcidev)[0];
-}
-
 static int cci_pci_alloc_irq(struct pci_dev *pcidev)
 {
 	int ret, nvec = pci_msix_vec_count(pcidev);
@@ -235,9 +227,9 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	u64 v;
 
 	/* start to find Device Feature List from Bar 0 */
-	base = cci_pci_ioremap_bar0(pcidev);
-	if (!base)
-		return -ENOMEM;
+	base = pcim_iomap_region(pcidev, 0, DRV_NAME);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	/*
 	 * PF device has FME and Ports/AFUs, and VF device only has one
@@ -296,7 +288,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	}
 
 	/* release I/O mappings for next step enumeration */
-	pcim_iounmap_regions(pcidev, BIT(0));
+	pcim_iounmap_region(pcidev, 0);
 
 	return ret;
 }
-- 
2.46.0


