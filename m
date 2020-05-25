Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73B41E17CC
	for <lists+linux-fpga@lfdr.de>; Tue, 26 May 2020 00:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbgEYWR4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 May 2020 18:17:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7188 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgEYWR4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 May 2020 18:17:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecc43c10000>; Mon, 25 May 2020 15:16:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 May 2020 15:17:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 May 2020 15:17:55 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 May
 2020 22:17:55 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 25 May 2020 22:17:55 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.58.199]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecc44130000>; Mon, 25 May 2020 15:17:55 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>
Subject: [PATCH v3] fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()
Date:   Mon, 25 May 2020 15:17:54 -0700
Message-ID: <20200525221754.433023-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590444993; bh=4ahN1Psg8kTbEIZNqr1dmwwmSlPtEFCt1AcWooHiPdU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=kDa5WFM5rbreLXpsPa0TciRz+ysOGYu+j8CR8els8GvIDpZKuEZwTHn8dUJNqoJLU
         fOUu1y3QwiydJlBBHRuPPboQBibLrc8CIMTRuBoxlNnz9thFJwRv2gMZ/iqJUp2Zmq
         wX7lBFW8Iv4WG6QXnNH8sN+AlqaphmmlIXqnOChgeDz0s0cw961D/aLWE73V0bxFXN
         asWOr/g6g36nwzNlRPBzxjVPOSD3MqO+Crme23pZa64BdFdpLKSAkE02ObazJoOZnl
         bB6AuSWzwMvnzg9HToK6JtyndvNj6xWbqOa1KYFr2pEcVzNFrxUM/m2erWr+UkojEv
         SNiB+wZzbAmyA==
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

Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

This is the same logical change as in v2, but it is applied to
char-misc-next, in order to avoid a merge problem with Souptick's
commit c9d7e3da1f3c ("fpga: dfl: afu: Corrected error handling levels <Soup=
tick Joarder>")

thanks,
John Hubbard
NVIDIA


 drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-r=
egion.c
index 5942343a5d6e..0b817b722920 100644
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
@@ -57,22 +48,22 @@ static int afu_dma_pin_pages(struct dfl_feature_platfor=
m_data *pdata,
 		goto unlock_vm;
 	}
=20
-	pinned =3D get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
+	pinned =3D pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
 				     region->pages);
 	if (pinned < 0) {
 		ret =3D pinned;
 		goto free_pages;
 	} else if (pinned !=3D npages) {
 		ret =3D -EFAULT;
-		goto put_pages;
+		goto unpin_pages;
 	}
=20
 	dev_dbg(dev, "%d pages pinned\n", pinned);
=20
 	return 0;
=20
-put_pages:
-	put_all_pages(region->pages, pinned);
+unpin_pages:
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
--=20
2.26.2

