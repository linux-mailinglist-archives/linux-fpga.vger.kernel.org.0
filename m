Return-Path: <linux-fpga+bounces-704-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56305967F6B
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Sep 2024 08:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB47E1F2280E
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Sep 2024 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006715688F;
	Mon,  2 Sep 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyGh2hFJ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B0185B7C
	for <linux-fpga@vger.kernel.org>; Mon,  2 Sep 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258275; cv=none; b=XPM7xKd/e+OZlfS0y64lT5GxWEiXe+dJNZZdHTP0w6H2U+w+sOVJ4NGM4G5BogmSvR+EiUKdz5xF9gyGAV6JhRQ5Zz/VjDBhW0vfLqHCnm6oFKDJ+bhqUnQBfOk0XoFP218IBhcQ+kcuIBlEyTCtibsA5mXkFswt7CU0UTiNaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258275; c=relaxed/simple;
	bh=Fc7LqA4dsnee2e9i3xlXjC/frSEy4rrwVedoLFfxfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILShz732M7oMiu1cqvHJcR2JiXVQQ5I1w5gYxIrFl6nLIprd73DFR1K5rRaEoVqHZQogVdYc1E9EmsJI7OrwShflYUsQ3TP07Wgw9dGQFL/7LNVZ5RyvkCKO/FHeFvfPw2raFTKAOzl3OOZFL6UjJdhIw+amIutqovlneU0sYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PyGh2hFJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725258273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
	b=PyGh2hFJpfpz1Sw4GHa51hGHDN45XnH+ik+G75Zb1+vzu6f0Nrf54GQ7Zuj6oXEc9zQY3D
	NECcYpxULp+O/f2//V1O8QyUOZYmQWdSB89zy7vSthUXnGvbakKpuROZreTLD6Tz6BacpO
	ys4dN4Kdug+coauluAk2I3StA6GbtNI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-5HUz8wIyNr2zkFO-XLPBEA-1; Mon, 02 Sep 2024 02:24:30 -0400
X-MC-Unique: 5HUz8wIyNr2zkFO-XLPBEA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-846c51fb226so399205241.1
        for <linux-fpga@vger.kernel.org>; Sun, 01 Sep 2024 23:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725258270; x=1725863070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
        b=iMtwehzVa5qzo0tyzUXbEdFkr3pHY6V8qAh5eidY9OT4tcFHXmcVnHSsuduR+ZtboP
         4+HM3g1eTyBbewrvKABftZu8hHIZmJ4kxPPA4jspZMjFLbhNoNMB3m6YKfCGNs8uGYUq
         qzBjDiD5bKsWsVCRERYd0HAnGGcO+SSIMHKUoI4dJQyd86km/rn8XBS06CPOIx15q+eI
         Wj59uct2lgEjjFeIsSIePENOHjWDbsNhgeDW45yYGvHDykQROh60OAhO1U9Z+0RDSyod
         qVbTWTU6D6UkLrpo2sABe1PoXHGZwl/y6AmdOQE0z5iaDzJ3oxpox8aeIYeZGIjUg5fI
         OKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWyzau+3VcQnH2XGWrMIdHVGhlOM+0UtmA78f7sGL/YguMQkIGNYrgZngzbDVkNIDT/QiEF1FxUgIf@vger.kernel.org
X-Gm-Message-State: AOJu0YzFclTExpfTTLfG/9lR0Yy7ivTiAF4y5FGiKfSZedX+Cnz8e5yz
	e2MUF1+3tVQj65hNEdGilc1Q+qSRh+GhLvhSkDC+VFL7I3G+L9kDcpBctisjeCK46QHktHzlxox
	/pD9CJLwLVU5XFLNyhvdgNE2UBwa5tgoMAcqIe9Wijrw22gGgWIOAzB7pALc=
X-Received: by 2002:a05:6102:3e89:b0:498:ede5:b20f with SMTP id ada2fe7eead31-49a779a41c8mr7270553137.19.1725258269933;
        Sun, 01 Sep 2024 23:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvKk7L/2Q+f5ePTEDKBoGd9wpJAI1J/cRLRuOI8ztSXLRi4Uiggu4Svtva7Pn5OPFtOZyMyA==
X-Received: by 2002:a05:6102:3e89:b0:498:ede5:b20f with SMTP id ada2fe7eead31-49a779a41c8mr7270533137.19.1725258269592;
        Sun, 01 Sep 2024 23:24:29 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3a34asm389211385a.84.2024.09.01.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 23:24:29 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 4/5] gpio: Replace deprecated PCI functions
Date: Mon,  2 Sep 2024 08:23:41 +0200
Message-ID: <20240902062342.10446-6-pstanner@redhat.com>
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


