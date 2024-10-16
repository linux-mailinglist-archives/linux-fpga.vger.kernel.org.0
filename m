Return-Path: <linux-fpga+bounces-780-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04149A060F
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Oct 2024 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5BAB24BCC
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Oct 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46710206056;
	Wed, 16 Oct 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAMsMcQv"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44063206052
	for <linux-fpga@vger.kernel.org>; Wed, 16 Oct 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072173; cv=none; b=mzQbq1OOV8wYacgHEZf/CtPUvdBoXm7cfcxxfwSl9BcxXz3eJqQJwupcJvNiDrFQaO/aGM3UnKge6ZyuYu29ZlTxKXHbuOKifZDW7D0GzfXr6+XNCunuXtm+uO5ucKPAclLGawbzlfznA3hxGqAl8Y2JOKwrYH6gMJ+n3CGCC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072173; c=relaxed/simple;
	bh=htHW4nC4bbnEa+ZM/uajB/3THIEyeC3KtURYUab+gk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqTdJnSB/j/cjclb8ZWhD2PZ0GvzFtM7a8akBWE9kvzRzt+17+Qg+La6MUQ36N7vMeoxZXxIqAgTn7+AsU2DvS7czgVcOmh4c8CkCOvguOhsbdybGgsmB33K++apAWpCYQVa30V5iQ2p8PQmWZuLVo8BxWbaAdgSIQdisinzOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAMsMcQv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAXbZXITqmfuNpuSA5zLMkRUqa2IYxNYDUv+NC55td4=;
	b=PAMsMcQvkUYrWUKsVAKMR6MQTkZoyqnVv3r/aJF9G3c9NXErptBNerPWDIO8MpT5T+C14g
	s3MMgb/IQ0vLPSwRSjbfQHE2FbYmrNR9gSjJhKwrJfUm7O44rAvmDi8+BaE/IpVhBhRgvB
	pMy8cY0iutaIIM0J5TMdA/LV7i380Cs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-AkM1OwUYNg6_jqGF6NF2CQ-1; Wed, 16 Oct 2024 05:49:28 -0400
X-MC-Unique: AkM1OwUYNg6_jqGF6NF2CQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4311db0f3f1so34234225e9.2
        for <linux-fpga@vger.kernel.org>; Wed, 16 Oct 2024 02:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072167; x=1729676967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAXbZXITqmfuNpuSA5zLMkRUqa2IYxNYDUv+NC55td4=;
        b=umOq1BaQGn/HIerlG5cCB4mUCp6UgxSg0Cl9nIJkjUo6MvbeG3Mf4ZfXL4/6hXYohV
         KbuX7ap5PX9c41vNbOiGIzDO8B4stziTi3XaKIehKDXtc4+ZEQ3V1Mt+KyDPEPjctZr+
         nwJ0OgXZRbvefq8WWdpACKYoHIE5E+CVIPdM4iDv52xPiNl1kzFA5CZmO/l28rZ0Czf9
         33t3bI78942WQBQosfdpkFjFzDhebaNBRidSlCT5qFTPYI5GQtVZO9YJIUPonmZ+Nsts
         14fHbodpypm5u6qyi9xBxih3Nf0SDAimSmBu+NhfwBR43t0/0PPebuR79fCJ+mn3b9g6
         QMiA==
X-Forwarded-Encrypted: i=1; AJvYcCVhHKYqNPfjb98MJxvKn3t0xykn6zT4FejAvTWnGiuf+86KfiX5UzGSTIJCjGCKvtbUaDTc+0Iu3H/2@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPDgnpWcKaD2k/LjwlCJQs4xsT/v5f6Ob7W1bonpx3+85+hfO
	LXZsJcJkDve0xgHEPW4RcLzsHf5z8cCInVeZGdgAMIeCCVuzmSqZPZYMKVY3tuIG9x67p+y6td4
	Xy1i6wo4eoQNiAPPMjbUTIYbnTGx7LvSz2nGdEnKwHywtvgjHIenrI8Okz/w=
X-Received: by 2002:a05:600c:1f8c:b0:42c:b220:4778 with SMTP id 5b1f17b1804b1-4311df5c639mr160032985e9.33.1729072167219;
        Wed, 16 Oct 2024 02:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmQuyn8hv0hBqxE0+BXi1ZnR8824mqMCiYlhK9JU94GmSaFPjJpOmCYUVQWoBnqBXMHnWe8Q==
X-Received: by 2002:a05:600c:1f8c:b0:42c:b220:4778 with SMTP id 5b1f17b1804b1-4311df5c639mr160032565e9.33.1729072166725;
        Wed, 16 Oct 2024 02:49:26 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:26 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 6/6] ethernet: cavium: Replace deprecated PCI functions
Date: Wed, 16 Oct 2024 11:49:09 +0200
Message-ID: <20241016094911.24818-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016094911.24818-2-pstanner@redhat.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
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

Replace the deprecated PCI functions with their successors.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
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
2.47.0


