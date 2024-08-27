Return-Path: <linux-fpga+bounces-673-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F896175D
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Aug 2024 20:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ACD1C23544
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Aug 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C91D2796;
	Tue, 27 Aug 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+U4Vk49"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A01D2F49
	for <linux-fpga@vger.kernel.org>; Tue, 27 Aug 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784987; cv=none; b=h5RsLjCmw6zwo2QUwTLssGVyF77s5db4Y0q6pJVyxnl7IDqUCitK4zZjdsrMT6ySdG4i0b3MeNk8KD1dRPByqeMprf+qAIqzrjhgVTmQ9ZKIbZ0fGk59l4GcwLOIZx3aueOHEmVxelYJkPaqBA4nLxHfqTnQKQ6+aCLiXjI/CRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784987; c=relaxed/simple;
	bh=CJHmsoWvlhgXbuGyDeTcSmbhobZOpm0m1tO85FGkGME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVPeUm+7JvwSkCOJErgaUXyx8WLJriKRO/efeU+HrEwqm2/HHSObGWmoupMl3gTCFyIW1HdZzcCYqvKLgRjRV6m4gHhiRFZ7NUBOy6mH1+v7L/vsQKDnraFU9h1oj4/CDW/sP6q1vcKdGX0/59XS0mZPyZeu4FnjvzDKpm2msOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+U4Vk49; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBx2d3MnnHRZ9pOfuC8799OJBEwqZxT6CHHpA17gZJs=;
	b=N+U4Vk49KH/5FxOedg6lIqU6ZdJ3jBljkx/caoXKzG1fTLdXgFAKMwy+va5YFWbjg0Snp7
	ZRnrV62Ax2/xiVTFi4Ox8cXX97qg5cNQL+5L2OaZJcGQdLU1OxcgolrcKoYdRIqUjJu+yu
	kZy6dOW2TDLbMIq24zLFxwgHlswOuc0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-rpbWmGGNPdmY8bx3hg012g-1; Tue, 27 Aug 2024 14:56:23 -0400
X-MC-Unique: rpbWmGGNPdmY8bx3hg012g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c085b4f665so4951306a12.3
        for <linux-fpga@vger.kernel.org>; Tue, 27 Aug 2024 11:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784982; x=1725389782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBx2d3MnnHRZ9pOfuC8799OJBEwqZxT6CHHpA17gZJs=;
        b=BYoSwWBvjWplZ6cdUCecNGiiDLOmBSS4Y4GnUiu4ZuEfjnZ0iGYeI6x3TKUJo0xJPp
         2rZyr8iJXofTzNyuJ+Cosb5p7QEc+GQYChGShLu91Fl7J/VY4MeFG4g2v+4VesP60I7c
         W2QVCA49ui5piLi4vGVNMwF4UIG0QonYsGAbRDFCKaxfH1LO9A+fyPvXDRrctfIjNiTP
         QAFMOE3bC9V+QablcrFut9Sjl1CLJNhZilaCrvZP3eRIcXvdRBfCEZ9dNnl5ixcPMOfl
         6jd7eNsRgSYN2EQYvENSZ4u8KVB2knmhp+80eG7fDwUgGYrrlA2CqnQmc/wPooEDBLuH
         Gjag==
X-Forwarded-Encrypted: i=1; AJvYcCVkoIj71IStWKhCrYNuDgVz5Cx31YacSgULcsM0cEbTfk+K9ff4HVX8Dk4kuBmML7xmuoZBhoMwrcRc@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGgu7A612dFamEvhzSKS4mPvFxjfKNEAd9DRZKrUSJCg3UJIV
	mi3ubH6lFBSZXXw+ewBseUS0s31VK4CkHXInZTA8JwYUy5Cnv026atP50MLdsgQHRfXFPPBVxBe
	9Qbw2FSnygCKFcTvjKT2UDm/sKxaccBralUjoww3gL02fSvpeGyMGQp4qAqM=
X-Received: by 2002:a17:906:c105:b0:a7a:9ca6:531 with SMTP id a640c23a62f3a-a86a516e4c0mr1224713166b.4.1724784982098;
        Tue, 27 Aug 2024 11:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+d3rlFWbvjaoHkp2NX+cFJBCozxT1sW8jPrYEKKHdJTUQoIyOjTNPbzyIkmF6NcfILE9xNg==
X-Received: by 2002:a17:906:c105:b0:a7a:9ca6:531 with SMTP id a640c23a62f3a-a86a516e4c0mr1224709366b.4.1724784981629;
        Tue, 27 Aug 2024 11:56:21 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:21 -0700 (PDT)
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
Subject: [PATCH v4 1/7] PCI: Deprecate pcim_iounmap_regions()
Date: Tue, 27 Aug 2024 20:56:06 +0200
Message-ID: <20240827185616.45094-2-pstanner@redhat.com>
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

The function pcim_iounmap_regions() is problematic because it uses a
bitmask mechanism to release / iounmap multiple BARs at once. It, thus,
prevents getting rid of the problematic iomap table mechanism which was
deprecated in commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Make pcim_iounmap_region() public as the successor of
pcim_iounmap_regions().

Mark pcim_iounmap_regions() as deprecated.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 8 ++++++--
 include/linux/pci.h  | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b97589e99fad..5f6f889249b0 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -771,7 +771,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -782,6 +782,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
@@ -1013,11 +1014,14 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 EXPORT_SYMBOL(pcim_iomap_regions_request_all);
 
 /**
- * pcim_iounmap_regions - Unmap and release PCI BARs
+ * pcim_iounmap_regions - Unmap and release PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to unmap and release
  *
  * Unmap and release regions specified by @mask.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pcim_iounmap_region() instead.
  */
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 01b9f1a351be..9625d8a7b655 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2297,6 +2297,7 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.46.0


