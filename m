Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448A31D650B
	for <lists+linux-fpga@lfdr.de>; Sun, 17 May 2020 03:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEQBSk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 May 2020 21:18:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15880 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEQBSk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 May 2020 21:18:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec090640000>; Sat, 16 May 2020 18:16:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 16 May 2020 18:18:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 16 May 2020 18:18:39 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 17 May
 2020 01:18:39 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 17 May 2020 01:18:39 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec090ef0001>; Sat, 16 May 2020 18:18:39 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH] fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()
Date:   Sat, 16 May 2020 18:18:37 -0700
Message-ID: <20200517011837.382189-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589678180; bh=sy5Ui646d3AglpuvJNOHEZAV8PuLDjy03kGDT/+711M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=DgTc3wEMsvu2GAVTe6yofPjfTj/tyiextWIZRdMbPXhkzSY/yAA5OoUXktRiPhoRv
         0BjkGKWXewSnc4RMorHErEMcKvvNQgDvZQtsgaEE/BovLIivQKFw8gsC7HCnuPkzYO
         ER8kWAXH14Cz3Zs9HExShG40WMtQvLEnXOHurO6aCcvFSpPo3gvt574Bp4EYm4I0Ag
         AbnypOmDR8lEtyb5oNrCosXh0MuW//q7GGNn4ZORbCW4iNRjpXotitBIzqibmIjeFY
         u5yMkyQnjhr10tRkhT7g+1BoJrqeEPw6KUYSF9yiK62Xj5aPW96xhMLgaDASfZdyAd
         AnEs8xyOkoO1A==
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This code was using get_user_pages_fast(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages_fast() + put_page() calls to
pin_user_pages_fast() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-r=
egion.c
index 62f924489db5..84f696d5ba82 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -16,15 +16,6 @@
=20
 #include "dfl-afu.h"
=20
-static void put_all_pages(struct page **pages, int npages)
-{
-	int i;
-
-	for (i =3D 0; i < npages; i++)
-		if (pages[i])
-			put_page(pages[i]);
-}
-
 void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 {
 	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
@@ -57,7 +48,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_=
data *pdata,
 		goto unlock_vm;
 	}
=20
-	pinned =3D get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
+	pinned =3D pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
 				     region->pages);
 	if (pinned < 0) {
 		ret =3D pinned;
@@ -72,7 +63,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_=
data *pdata,
 	return 0;
=20
 put_pages:
-	put_all_pages(region->pages, pinned);
+	unpin_user_pages(region->pages, pinned);
 free_pages:
 	kfree(region->pages);
 unlock_vm:
@@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platfo=
rm_data *pdata,
 	long npages =3D region->length >> PAGE_SHIFT;
 	struct device *dev =3D &pdata->dev->dev;
=20
-	put_all_pages(region->pages, npages);
+	unpin_user_pages(region->pages, npages);
 	kfree(region->pages);
 	account_locked_vm(current->mm, npages, false);
=20

base-commit: 3d1c1e5931ce45b3a3f309385bbc00c78e9951c6
--=20
2.26.2

