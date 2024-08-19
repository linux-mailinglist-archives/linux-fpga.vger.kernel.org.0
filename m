Return-Path: <linux-fpga+bounces-593-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D89570EE
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Aug 2024 18:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57B91F2291D
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Aug 2024 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E164F179202;
	Mon, 19 Aug 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxfo23yQ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBB179953
	for <linux-fpga@vger.kernel.org>; Mon, 19 Aug 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086354; cv=none; b=Hf8opWlGoOclAZlIJ1wKyRejEvW6VUemQ4+Zyt/HKtEyXp1UROb98PgtnyTsqrMbioDnods62Gr13A4t5Al6KA9oNSdBzkFha5FZtyaDBmtvdeMt1KqJh4ramznitJ9J2cRgG45MatcLmmykU6Qea69tBxriWkTXpnFsoE7TTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086354; c=relaxed/simple;
	bh=StzfX7D+b5jZ3LVEyPb0XmRGLTAQPRkMUDb8wVYSh3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4TsJ5X/SVbF4uOma7sK2H7ms1OWOlEnp4mnIhOhI2gUG8n5UhsontjN3v9aOWUguiWlqj051yOcr/tksCGzbMHScHIFShUciDfWeisvNL5eeDmlha9psAqKlG8yvSAzjjn4mQAUsaM9PvRtFPDOX0nKQjUeTJSJhL3lV4EKo9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xxfo23yQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oDgCmWXPsT/ByKSJo2B5hdxGUNecM9yTJg3LqwyPBvM=;
	b=Xxfo23yQ0nYOA/N2Y8IbZpb9fgzE0BwTc3vrpbg+d/vjGa1oZJJvJGPbYjU6muPXtS1ERg
	WY2bbIBgpTIC7Jr8bXvIcXxm7vAcqe462tYv5Jd/qawbuTZnF1+qzxw1XOKpVDLwHdY4LK
	7PvBWaJoknlVrtsrXp1rI/r9Ry9imps=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-I9sozgEjPcOvMjsTRgP1kw-1; Mon, 19 Aug 2024 12:52:30 -0400
X-MC-Unique: I9sozgEjPcOvMjsTRgP1kw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7093752a9f5so827676a34.1
        for <linux-fpga@vger.kernel.org>; Mon, 19 Aug 2024 09:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086350; x=1724691150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDgCmWXPsT/ByKSJo2B5hdxGUNecM9yTJg3LqwyPBvM=;
        b=oZUqUve6ouLvaV3DS4C3AO8LrSEnGHWeYb7pemRgPeUj0ZfuFIstxGTCUCnMf1Zluo
         vEKUcXUybgT6u0WVoWfdpC2MvSph20604YvZY4yKiciQt9p/gql1i52nsoQoNGrS9MwW
         GO3CPztMGXVg1Mo7gBEoII3q2A8yJXbObJ8Vb9Aay9KeVE0FtDwffMH463DMYvKuKzHJ
         hFXTsP1VGec3mkLfpd5PNjmV46i29N7R15hwna1cc/mcKOWGeITwX7/io9BMpBmerJ8t
         5A6ARhLm2SB5hacnysXgsmzzO0E7vjY0L0XQFrtUx89kSola4H0ZvzB8xJ1SjruA6qkt
         MD/g==
X-Forwarded-Encrypted: i=1; AJvYcCUcbAmeUBWSnKdMZD4Uch690OE2JcL/IyPlHl7ILfEWNKgzmrzyq8LyOpFB3qCtnufUAq2elJxAUQkj@vger.kernel.org
X-Gm-Message-State: AOJu0YzsN2YM3+Jm7GTh1agL6vG6NkoOoC7k+7qL4cwDMYpeHXdnU/H1
	XD+l7ulTypMPj3FCxr8fielLbyaT8JKSVOw8SWzQ9vcxfOWX3Azs5Z06Kxe1Bf8r/zIFFbpehSA
	zpgDkGqVG8dK9KIzUL3ySkd4uhkx8GBrok23gZFOHcU1D2SS6XCN24GEBJK4=
X-Received: by 2002:a05:6359:4c87:b0:1ac:a26c:a5e8 with SMTP id e5c5f4694b2df-1b39333e0c1mr737790055d.4.1724086349989;
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEksR+Cpw2eRNuHRkEIfwdvURGCWFxAEIEKM8Aw05iYSBMnqj3x39V0KKigIE6pVo5nSVtsiQ==
X-Received: by 2002:a05:6359:4c87:b0:1ac:a26c:a5e8 with SMTP id e5c5f4694b2df-1b39333e0c1mr737785755d.4.1724086349577;
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>,
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
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
Subject: [PATCH 0/9] PCI: Remove pcim_iounmap_regions()
Date: Mon, 19 Aug 2024 18:51:40 +0200
Message-ID: <20240819165148.58201-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Important things first:
This series is based on [1] and [2] which Bjorn Helgaas has currently
queued for v6.12 in the PCI tree.

This series shall remove pcim_iounmap_regions() in order to make way to
remove its brother, pcim_iomap_regions().

@Bjorn: Feel free to squash the PCI commits.

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (9):
  PCI: Make pcim_release_region() a public function
  PCI: Make pcim_iounmap_region() a public function
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions
  ethernet: stmicro: Simplify PCI devres usage
  vdap: solidrun: Replace deprecated PCI functions
  PCI: Remove pcim_iounmap_regions()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/block/mtip32xx/mtip32xx.c             | 11 +++--
 drivers/fpga/dfl-pci.c                        |  9 ++--
 drivers/gpio/gpio-merrifield.c                | 14 +++---
 .../net/ethernet/cavium/common/cavium_ptp.c   | 10 ++--
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 25 +++-------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 18 +++----
 drivers/pci/devres.c                          | 25 ++--------
 drivers/pci/pci.h                             |  1 -
 drivers/vdpa/solidrun/snet_main.c             | 47 +++++++------------
 include/linux/pci.h                           |  3 +-
 11 files changed, 57 insertions(+), 107 deletions(-)

-- 
2.46.0


