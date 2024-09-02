Return-Path: <linux-fpga+bounces-703-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF393967F61
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Sep 2024 08:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AED1F228B5
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Sep 2024 06:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D117B51B;
	Mon,  2 Sep 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqWd9xq9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0718130D
	for <linux-fpga@vger.kernel.org>; Mon,  2 Sep 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258270; cv=none; b=JXXMGEBp2PyAse8rxhvNw6MNokdlsr2EO6HBF4NuPx6cTyay4oJrHg3oIMgJhc/QGgPTpf6kiQmy/MDcUYfmVksGmwyntiDmaqMke8rrbyMXn6f+DO29MDtf9Jg9HQSWeU562rc7Zd3ebeGxJCziKISe+Mc/L5B9fuoo6OMjGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258270; c=relaxed/simple;
	bh=s4GctkYHbXn3tfM8TOsiQdy7M4dRLmQpFi1urTUZZ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCVX14FwUusDndvJEbWOasZ7bHixGju5K2NTRBC0tLsqLzX1nhi9WuzU3VEBwyTn2PqP/jTTJK7OyAN4EsyXktu5x8od4gXSQ3aKx7xEiCwcsecMkSqGjDDoQPa7wRa+eIeN7E8l1QMQ0G0HK0oyG4yEz9c2H7qShxcrftlrNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqWd9xq9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725258268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtYR/gGTmDbAPYmIYRccbXqwblJKOZwAhQg2Y6pwqmg=;
	b=QqWd9xq91hkO/Jy+Xfi/7nYQX2iR2QqNOq728m+SZPl5T+I0qLJOpZm2Kybu1FOWElJeSY
	1vUdA5Tj/EPy+6EXkpsuMmLrGXE5BnQP7kxJukJfGeY0LZvkYTO4OE9McTqtozJxN4N1l1
	jm6kYj3xyhzUJqnPwdgAvH7EgCLmR84=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-3zOoeXqZNZS_UFoFYQzntg-1; Mon, 02 Sep 2024 02:24:27 -0400
X-MC-Unique: 3zOoeXqZNZS_UFoFYQzntg-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-498f35d9827so1452140137.1
        for <linux-fpga@vger.kernel.org>; Sun, 01 Sep 2024 23:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725258266; x=1725863066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtYR/gGTmDbAPYmIYRccbXqwblJKOZwAhQg2Y6pwqmg=;
        b=Qlh9G38dSpOx+KXkus0MMEPTsNk6oFttDDd+fH3e70CY7QhpdaJ2hv1/vR2TDQH39Y
         jqdTcgLKOWZydjVs9o7p8tT+2Yxugbg1gRWQskNaLBqf/wq90n/Qj4I84T41+WxpypZP
         BJ2/eDks27SWuRltIUxCX4Al/8x5JBcDztlF6uHHtVaaYeBHgpsmwkwY6GwaoGbPD81w
         cNFPJBtOies6Fuib8++k42qZdr100fEZpXSkGAhLh0q88cL2wdg5rSHNGH4GNRGqGsZJ
         F/Gvyl4+YScUmBJjOWX0G+DWxkya2/WhpC8Hu6M1njidi77bunwwlAar5pWODcO5Eh9u
         tiAw==
X-Forwarded-Encrypted: i=1; AJvYcCX+giLT7Y2/aZIV25zc7h7L1TYBk1dy1KhQo0SQHYjK/gkKskJNx4BfB7uLz047l25UVfMyLr58w5dh@vger.kernel.org
X-Gm-Message-State: AOJu0YweoeqtiVw2s9/typwV5w/lqIt6waGRXSgB9Iz9M0ERttwj2Gb2
	gAsP/ibvdDENcNmE4hROYrBMr/g6zvBGFne1EvpuDIfyv41dKtRmxNFFkQgBw6opQk5c/n84bmI
	s1qpQftivTBrNFGXcLzgN976c3JS3FEKGDKrTc/m6Aca6OM9iLOhan3As5tg=
X-Received: by 2002:a05:6102:32ca:b0:492:aaae:835d with SMTP id ada2fe7eead31-49a77511b65mr8535888137.0.1725258266456;
        Sun, 01 Sep 2024 23:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFluumio3mIduLZuNyfcu74sOvja3KJmTiLmPPfUiTP6sb83KtvxfvnRpv/SNgep1ECH+mcbA==
X-Received: by 2002:a05:6102:32ca:b0:492:aaae:835d with SMTP id ada2fe7eead31-49a77511b65mr8535871137.0.1725258266122;
        Sun, 01 Sep 2024 23:24:26 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3a34asm389211385a.84.2024.09.01.23.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 23:24:25 -0700 (PDT)
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
Subject: [PATCH v6 3/5] block: mtip32xx: Replace deprecated PCI functions
Date: Mon,  2 Sep 2024 08:23:40 +0200
Message-ID: <20240902062342.10446-5-pstanner@redhat.com>
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

In mtip32xx, these functions can easily be replaced by their respective
successors, pcim_request_region() and pcim_iomap(). Moreover, the
driver's calls to pcim_iounmap_regions() in probe()'s error path and in
remove() are not necessary. Cleanup can be performed by PCI devres
automatically.

Replace pcim_iomap_regions() and pcim_iomap_table().

Remove the calls to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/mtip32xx/mtip32xx.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..e4331b065a5e 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2716,7 +2716,9 @@ static int mtip_hw_init(struct driver_data *dd)
 	int rv;
 	unsigned long timeout, timetaken;
 
-	dd->mmio = pcim_iomap_table(dd->pdev)[MTIP_ABAR];
+	dd->mmio = pcim_iomap(dd->pdev, MTIP_ABAR, 0);
+	if (!dd->mmio)
+		return -ENOMEM;
 
 	mtip_detect_product(dd);
 	if (dd->product_type == MTIP_PRODUCT_UNKNOWN) {
@@ -3722,14 +3724,14 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	rv = pcim_enable_device(pdev);
 	if (rv < 0) {
 		dev_err(&pdev->dev, "Unable to enable device\n");
-		goto iomap_err;
+		goto setmask_err;
 	}
 
-	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
+	/* Request BAR5. */
+	rv = pcim_request_region(pdev, MTIP_ABAR, MTIP_DRV_NAME);
 	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
-		goto iomap_err;
+		dev_err(&pdev->dev, "Unable to request regions\n");
+		goto setmask_err;
 	}
 
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -3849,9 +3851,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[2].cpu_binding);
 	}
 setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
-
-iomap_err:
 	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
 	return rv;
@@ -3925,7 +3924,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.46.0


