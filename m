Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A516544F5A1
	for <lists+linux-fpga@lfdr.de>; Sat, 13 Nov 2021 23:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKMWQA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 13 Nov 2021 17:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233544AbhKMWQA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 13 Nov 2021 17:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636841587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yVoMOfDwy8Q0m/39gh0gDNPU0gOTI/GsdwFXBbgGHLc=;
        b=Je6CcBtIWrLiXTJXl1BnDbhcEj6yBCeQvViW/ZE5LIoi+yPCNV9pIzSfK0FVP+1qkgbBdh
        8+Ssl8NUIxbgTuPgqJnpGYBfUWXO7LkiCMxZEdaKvJ6ccPApH0I4FddjclElZHn6ykoqAi
        /WYMaeG8x/ZAvkuAOYJSsrrCGJk82kE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-H9GMK7FWPQGMtDVlAKnTvg-1; Sat, 13 Nov 2021 17:13:04 -0500
X-MC-Unique: H9GMK7FWPQGMtDVlAKnTvg-1
Received: by mail-pj1-f72.google.com with SMTP id bf17-20020a17090b0b1100b001a634dbd737so6452882pjb.9
        for <linux-fpga@vger.kernel.org>; Sat, 13 Nov 2021 14:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVoMOfDwy8Q0m/39gh0gDNPU0gOTI/GsdwFXBbgGHLc=;
        b=kY9LLocTnjsmdQ9/qTTwrKObScTtWJTJjVCQo7j6QBTbxkW+6GAt5WsVCBl47xEaE9
         hUZR09sUTj/AXLYZ5VnDUk1661NinIJh/RkFQArlVcMhrR+Qfn559sq64PBb9QZwcNhH
         /ezZhCZzzkwWc7hdXPRsJ6PJkAcP9lBGl9Pg62z06L4tsx/bzu4Y48wGdDTViyYQv34Z
         ioSv5QAv/ixqzgcQJrnn9VdLQh0Ho0fqJFvz2ChW/IYc9bFjfRdLSD67BL9b6T0ziE9r
         +VAKtK3DlVjG4wzEMjOX/Cqnl0XfGo/twrkja34GgWPdvqf6qzXbhG0NInh/r8Uy50PX
         0fPg==
X-Gm-Message-State: AOAM5317TPHrSGBupaWp0Nn3Z9Vi4rKNqiiRNvIhYgy70IptJWEaAx6M
        tAf79aa6Z+njAACMrzwBk3XvJhFTRlTT8NnAEAKo2flbUUEQhxJEc1eAlJnvCsqE1Z/Jp3zXWme
        z//fdXoCEPFjP3aDyGOTYWQ==
X-Received: by 2002:a05:6a00:ac1:b0:44c:4dc6:b897 with SMTP id c1-20020a056a000ac100b0044c4dc6b897mr23381717pfl.25.1636841582789;
        Sat, 13 Nov 2021 14:13:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZMYhHkvNs9tAiwjcm5+NqPix2hrqBvesc82Cx/xOQI7yWfXLU6nEamlLc+J8xq/t8pAiAoQ==
X-Received: by 2002:a05:6a00:ac1:b0:44c:4dc6:b897 with SMTP id c1-20020a056a000ac100b0044c4dc6b897mr23381699pfl.25.1636841582534;
        Sat, 13 Nov 2021 14:13:02 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j6sm7908688pgf.60.2021.11.13.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 14:13:02 -0800 (PST)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, yilun.xu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: dfl: pci: generalize find_dfls_by_vsec()
Date:   Sat, 13 Nov 2021 14:12:52 -0800
Message-Id: <20211113221252.4062704-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

find_dfls_by_vsec() is a general dfl function.
Although dfl has multiple vendors, only Intel is supported.
Move vsec and vendor id to an array variable.
Other vendors can append the array to enable their support.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-pci.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4d68719e608f..9dc0815c8274 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -136,19 +136,36 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 	return table;
 }
 
-static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
+struct dfl_vsec {
+	u16 vendor;
+	u16 id;
+};
+
+static struct dfl_vsec vsecs[] = {
+	{ PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS },
+};
+
+static int find_dfls_by_vsec(struct pci_dev *pcidev,
+			     struct dfl_fpga_enum_info *info)
 {
 	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
 	int dfl_res_off, i, bars, voff = 0;
 	resource_size_t start, len;
 
-	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
-		vndr_hdr = 0;
-		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
+	for (i = 0; i < ARRAY_SIZE(vsecs); i++) {
+		if (pcidev->vendor != vsecs[i].vendor)
+			continue;
+
+		while ((voff =
+			pci_find_next_ext_capability(pcidev, voff,
+						     PCI_EXT_CAP_ID_VNDR))) {
+			vndr_hdr = 0;
+			pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER,
+					      &vndr_hdr);
 
-		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
-		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
-			break;
+			if (PCI_VNDR_HEADER_ID(vndr_hdr) == vsecs[i].id)
+				break;
+		}
 	}
 
 	if (!voff) {
-- 
2.26.3

