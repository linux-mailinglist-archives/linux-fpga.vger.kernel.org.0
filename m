Return-Path: <linux-fpga+bounces-676-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D2961772
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Aug 2024 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4901BB226EF
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Aug 2024 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE51D45E4;
	Tue, 27 Aug 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CY3wKPh1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76E1A08AD
	for <linux-fpga@vger.kernel.org>; Tue, 27 Aug 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784992; cv=none; b=iG+yHsx7r53qJWShzohe7mGvciJpkypLHgcehGZMMrhk9PbWxplfo7lcWGbw7gPtVW+6HGyxhkClLNkebQLO8TrOJOJtoJ7jcABz+GUUuuMZZlEnftGmV9NJsVujoO44rLAelzzidCjsXCDs4/LkEZrMN0ZAXi5eFNzKmZuASlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784992; c=relaxed/simple;
	bh=Fc7LqA4dsnee2e9i3xlXjC/frSEy4rrwVedoLFfxfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMIxE90OM5mpEeoKaspWo3o+LUzrADcLFBH5Trsq4KqKbB9jPQJizqt0UIPKQtChW3KffoPq8bW4iDTAC6FAFp/lCj5rnGbLWfjyekTHFDdlJGNjFrkvK6V5dWAQ9otJqpGc5oq7ISHRZlvJoLm+brbR8SH2ShTxkU2BBlEAXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CY3wKPh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
	b=CY3wKPh1rKk4tPoqcQyErpLK3+ZIqJCH7Yq67p3QuDanWTRikxjQeTd+eDBv30UzRpkd2/
	5cjmNfhnpkjZri1S1bxkY5meXQ1ZqRn3BA/KEhFDjVCcmjWPE/Mkjlm0+QeQJVI9Im1gr9
	ILs7ZQmArz60vEkgt1OaXwH3/kBDmGw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-A9w7hVxLNgifPXTLW93jwA-1; Tue, 27 Aug 2024 14:56:28 -0400
X-MC-Unique: A9w7hVxLNgifPXTLW93jwA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8685464a7dso482711266b.1
        for <linux-fpga@vger.kernel.org>; Tue, 27 Aug 2024 11:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784987; x=1725389787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
        b=Ku1N4/FomZ+DgsnzseOrB82RZvnRFceMKXteH0wBlP/+EkqOWAGtbejyuXMlX6b8uk
         ja8EqT85MzZ9HFxuRmW9G7BxlpjiynDelpvgBy7pdSbnWARU/i7PIKknSmrEroWI7fqm
         CjEv85o/F1Hpqv9hF5y4ZP23a9Yhz+/ymWTxrqFqoNlVNRF2eie2lsiHShfnHqKeWUfa
         t70tZhrLno2xwbKFmTH16yU/ANrxYdCUUs3d1m/v4ipx9Mw0xmLgfNTeQqQAahppEbW6
         i0lUD8qOKWWQVIz0FMPQZW7XQFqnAaDf6gikzqbqfLmSUIVgfKGVlOTMR4JJfp91cYBX
         D4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXIe1z8g8Hi6A22DHDu8+BoR+ysZyfzLMw/H0k/IkrF+SBdSPGf5slQRw3K5/fDyARfq3QLs9V4Pz0W@vger.kernel.org
X-Gm-Message-State: AOJu0YxEF4m5wedQI06ie2Q/ANrBc5GXADWuGadXfHd/iQiZTsqbbrif
	vxR/vIosPkfsUdpCcHEEnDITY1Kg9AFq9D7UInt4jzrEtK+EfTvzSG1yfTv22ZG8F8hVBJRwn3Z
	IYpIwngOE0c7bXE2c+zzkbshJ8VUUY1xw8D4sy4Ix+Dj/iZiCe3NandasY1s=
X-Received: by 2002:a17:907:1c18:b0:a86:880e:eb7c with SMTP id a640c23a62f3a-a86e3d4d268mr222025166b.60.1724784987127;
        Tue, 27 Aug 2024 11:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxGSDqS2TZbtJE8cSGpMf7ENec796YeMAplFL1fwkmHHmNQCeEVuMFIsH34dzhyzm3h6h9CQ==
X-Received: by 2002:a17:907:1c18:b0:a86:880e:eb7c with SMTP id a640c23a62f3a-a86e3d4d268mr222023366b.60.1724784986665;
        Tue, 27 Aug 2024 11:56:26 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:26 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 4/7] gpio: Replace deprecated PCI functions
Date: Tue, 27 Aug 2024 20:56:09 +0200
Message-ID: <20240827185616.45094-5-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace those functions with calls to pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-merrifield.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 421d7e3a6c66..274afcba31e6 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -78,24 +78,24 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (retval)
 		return retval;
 
-	retval = pcim_iomap_regions(pdev, BIT(1) | BIT(0), pci_name(pdev));
-	if (retval)
-		return dev_err_probe(dev, retval, "I/O memory mapping error\n");
-
-	base = pcim_iomap_table(pdev)[1];
+	base = pcim_iomap_region(pdev, 1, pci_name(pdev));
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	irq_base = readl(base + 0 * sizeof(u32));
 	gpio_base = readl(base + 1 * sizeof(u32));
 
 	/* Release the IO mapping, since we already get the info from BAR1 */
-	pcim_iounmap_regions(pdev, BIT(1));
+	pcim_iounmap_region(pdev, 1);
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	priv->reg_base = pcim_iomap_table(pdev)[0];
+	priv->reg_base = pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(priv->reg_base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
 	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
-- 
2.46.0


