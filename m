Return-Path: <linux-fpga+bounces-677-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C646B961776
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Aug 2024 20:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9B41C23063
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Aug 2024 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D51D461C;
	Tue, 27 Aug 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFQEUApw"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE01D175F
	for <linux-fpga@vger.kernel.org>; Tue, 27 Aug 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784994; cv=none; b=WFLdCPHStu+vmf96K5JVT7ZPyMQ0M2tyu89vNxZNjmTmOM9XXqcXVV5yssmXTZw1BaF1hfhP+rG+KZyghwN/L9duk+oaRTjB/NcYNSAfQ9uIDV9JdoRH0F93WukQ6xOitZlhRhcbRfTJBXLyixXx5H1yYw1yWLfBrJnO7qGABSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784994; c=relaxed/simple;
	bh=ARR42U31SsfvWWCrHwbXesPCT1d63Wp8dyC5fYwgRtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iv2OWWfhm1f42warF/bi9Q7SBrgcagyl0mDe+2NSK/NvetLvgwc7H3pVCOz3ia438nONT/K/Ff2V8EXx+KKlfLmWblHaf+hZTpUYaU95c9zYFKyGYv1lcvOT/mhWYYaXybHDmtRZYxzZAQ85xIlws7tNpefs6fHnr/hTD+2UWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFQEUApw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot52nkK/Na0X35bsJx5mf+W03nkANhJiuieinuTtF+Y=;
	b=OFQEUApwQbs08IymIEu3CA4E2SKCuML2oYlQaIhxuYYGTvHdNdqe/AZ+0j8HNeALR06687
	8vhlUmf+5lEivN4hq+b/ydE+aunys24sv+mLppL04a0XpGOsmQhruXLF09D9gbuMwUMPCG
	69uxWZWjBncUTD79YWjAqMiRHknH4ks=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-nlh2_dOAOGGGkqQwTId7_A-1; Tue, 27 Aug 2024 14:56:29 -0400
X-MC-Unique: nlh2_dOAOGGGkqQwTId7_A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a868b6d6882so837366466b.1
        for <linux-fpga@vger.kernel.org>; Tue, 27 Aug 2024 11:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784989; x=1725389789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot52nkK/Na0X35bsJx5mf+W03nkANhJiuieinuTtF+Y=;
        b=ONAzJTSI6fdB8drbekvXr7vsQEF/NJ67M10o2gNQpRpcsoeebIWR/GxZwMY8VCQseE
         nkGIq08CqJk0JRWtJI/C8A3VY2pzhFTYfWIDO/uvr0aYk6nKgrxKirmgzCaPHSBogocn
         Lv3vjzHAQVUJgRHg80MEj0eoT2Tpjxv70gswp1WZ7yitupWT5TtibUh6fGKvapEa9gZY
         wKjM63N42HI2giwtEw2uXVmsa+4abzg6T0CFC0OVCAP6sIDDj//CAGSes2HmNWvNVh50
         SUHrZe0hmvp952+KBpWMOq7DUOTDzF2rrsycBJ8X0dpHeL2JCfMK9e62qogpf/n1NKV4
         KkiA==
X-Forwarded-Encrypted: i=1; AJvYcCV4CmFgy2zKXTp0o99Ys5cF857orKhR96z5ezbLTypdA/TYdY+qDJiKl9drxaK1c2JUsq9iWIYW+tQ5@vger.kernel.org
X-Gm-Message-State: AOJu0YwDS99EVO8yuluOWlwrJDFO6gPq0VKE57/eBlPCDjGIum+j9SXw
	8c5syoRBYkP79FRD9T0vRxZqBL6R5hLIwu7DTgbLh8tkTJpYTlMg5pa/Qp5aMKvTmIdngI6ra8K
	32BDHin/QE5yx8EE0kTc3UH+u4v8ycUph2AG9VvcBiocfU2CLUW3x/edDSZc=
X-Received: by 2002:a17:907:968b:b0:a77:dbf9:118f with SMTP id a640c23a62f3a-a870589d7bemr19229166b.13.1724784988731;
        Tue, 27 Aug 2024 11:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpPIsWnweTtHk2jYqlmIfKSsDaoipOeMWhXQ4B5bGcQn25jUZvX7EeAh161EGEDUYY0nmhrA==
X-Received: by 2002:a17:907:968b:b0:a77:dbf9:118f with SMTP id a640c23a62f3a-a870589d7bemr19227366b.13.1724784988317;
        Tue, 27 Aug 2024 11:56:28 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:27 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
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
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 5/7] ethernet: cavium: Replace deprecated PCI functions
Date: Tue, 27 Aug 2024 20:56:10 +0200
Message-ID: <20240827185616.45094-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
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
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..914ccc8eaf5e 100644
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
@@ -292,7 +291,6 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0


