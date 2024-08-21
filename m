Return-Path: <linux-fpga+bounces-637-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182F9595E4
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Aug 2024 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC572849D9
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Aug 2024 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B831B6535;
	Wed, 21 Aug 2024 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R353I+mZ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9281B652A
	for <linux-fpga@vger.kernel.org>; Wed, 21 Aug 2024 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224790; cv=none; b=HqpEdG7rEGdn4J7hQcrnZnVtjIXO7NqMeQKfNAllPYfeUlMWq5t3LvSSt+7EzOyJwwakEI5geoS/AkAMxBZra3sng75zR+rQiMQM+FX3vTmqsBOTQkKgoxC3CekoqL20p8QRb9ENmyFhNzmvLNFYR6jK0FF30zgSfHWCaVaouJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224790; c=relaxed/simple;
	bh=zz4g00AyrOlGbCFQ8xrM/DS+BcOL9w71mmIBYnsZsuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUHtKQGptfcxdvnyAFXa/UhKm7UuqJNaLAGbZjuBXwn03adn/wU+WBbSI01qoGJI+1ifDMe1UqzzMcpD062X0lBdxBvPb5+108MVBn7TRZ4X4WO7OwhKqlTUza+unrifzL3DJ9iodZ/7m+fmscQlgn8mxH4xa3FLiI9IPN7JYZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R353I+mZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jtoMc9tojKKL8iwWeM5ToAOyUwxh+I3f+1WrHk/fN0=;
	b=R353I+mZaLxpwHj/bza10KpIpHtqkHarneXvJNQhcMzTcVt5WtyR7WADLaWvS0MBX3kNT2
	zSFzwPSig0J2vU8hb/MelM9hgunq+ENH5pK1qdOtimCMA/oaKIlPLPnXXH7HjVaz8hd1+j
	HTQmQ3q5hRlo69+yiiEK+e8OR+yca8U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501--YfIlJxsPwym9WOgjFomIw-1; Wed, 21 Aug 2024 03:19:42 -0400
X-MC-Unique: -YfIlJxsPwym9WOgjFomIw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d4238d65so709438085a.0
        for <linux-fpga@vger.kernel.org>; Wed, 21 Aug 2024 00:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224782; x=1724829582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jtoMc9tojKKL8iwWeM5ToAOyUwxh+I3f+1WrHk/fN0=;
        b=GerswZd9hLBO9WuLm4sh5P7gN46N5j/zH5cBNYzG0BsT2O+HWjKtRys6J1LS6k/RgP
         iCKaePL4KUD8L4UTtIQU1woB6MR19wgMDkGAbbO+r9LO2Vf2qmrymkYMOk/imErU2CIA
         5SZ8+G39W2auah7DkewU/Uyju/vMzF/nExOMcqn6ZguumtbgrU9yk2hXoN3D3BXDvGZg
         iGswrVU/hjVzLhXUkDMaQbjnp0IaE/hznaPQnn7/M+x01hjo3rDWFiZtUkgpakxTgGXe
         h5FtGjjlMyaMj/9Mizn6UJFnqBQf6oIgweN89InQeiQ7lLBkLnZNvwOi8h7as+YwdCDt
         PXjw==
X-Forwarded-Encrypted: i=1; AJvYcCVpW2ZGTyzmZ8611SnZuto8k/6xA9kbIiDbe8FuiXTdR7+zlFHi5+30E3IBTz4aHm+5QOZRdP3ap28l@vger.kernel.org
X-Gm-Message-State: AOJu0YznbEit1ImGWn2vJQB9SeOn66KB4z+rUKUuLm5hGiBOdqOcS0Un
	8NUC4AQzQQn4ukrC6cAlzXC9qa2DMAwK/q1IGq7V4fOqH9kpGIus1iooKbp2vzX9s+AcBh8YMsh
	Yx6i4anbzyP9yFgEA2mU1w3mJUk8TRlAogfjy+hlTzIn9FEdMQE5VnO+YN/8=
X-Received: by 2002:a05:620a:3953:b0:79e:e302:7392 with SMTP id af79cd13be357-7a674047d68mr175952885a.32.1724224781992;
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEujbivdy0X82ZZM2IZtk3pa0uY+R6FAaLiHcgNfg5GEA0wo0Jm6V+lDWsOUg8+jqkxdP5bpA==
X-Received: by 2002:a05:620a:3953:b0:79e:e302:7392 with SMTP id af79cd13be357-7a674047d68mr175949285a.32.1724224781630;
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 8/9] vdap: solidrun: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:41 +0200
Message-ID: <20240821071842.8591-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821071842.8591-2-pstanner@redhat.com>
References: <20240821071842.8591-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
things because it forces usage of quite a complicated bitmask mechanism.
The bitmask handling code can entirely be removed by replacing
pcim_iomap_regions() and pcim_iomap_table().

Replace pcim_iomap_regions() and pcim_iomap_table() with
pci_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 53 +++++++++++--------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 4d42a05d70fc..ce336f261649 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,36 +556,25 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
-	/* We don't know which BAR will be used to communicate..
-	 * We will map every bar with len > 0.
-	 *
-	 * Later, we will discover the BAR and unmap all other BARs.
-	 */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
-	}
-
-	/* No BAR can be used.. */
-	if (!mask) {
-		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
-		return -ENODEV;
-	}
+	unsigned short i;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
+	/* We don't know which BAR will be used to communicate..
+	 * We will map every bar with len > 0.
+	 *
+	 * Later, we will discover the BAR and unmap all other BARs.
+	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
+		if (!pci_resource_len(pdev, i))
+			continue;
+		psnet->bars[i] = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(psnet->bars[i])) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(psnet->bars[i]);
+		}
 	}
 
 	return 0;
@@ -594,18 +583,15 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char name[50];
-	int ret;
 
 	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
 	/* Request and map BAR */
-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
-	if (ret) {
+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
+	if (IS_ERR(snet->bar)) {
 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
-		return ret;
+		return PTR_ERR(snet->bar);
 	}
 
-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
-
 	return 0;
 }
 
@@ -653,15 +639,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	int i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (psnet->bars[i] && i != psnet->barno)
-			mask |= (1 << i);
+			pcim_iounmap_region(pdev, i);
 	}
-
-	if (mask)
-		pcim_iounmap_regions(pdev, mask);
 }
 
 /* Read SNET config from PCI BAR */
-- 
2.46.0


