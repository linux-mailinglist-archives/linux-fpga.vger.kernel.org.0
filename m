Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5E3B4991
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFYUBg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 16:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229959AbhFYUBf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 16:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624651153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TgS1W0YkxnAj8zzimJEJj0dUofXVg1iWDV0xL3ii1c4=;
        b=Y87iV1KexXk+x4/lcg3LV2i+n3Wfr61K5EdEkDW+uqygXs7L2YkAhdIsx9FpKRqzmYh4WY
        jAGZXO7le0j6pUC/i8gnwC936ddQhdCeaovP3B5a4/5y+EffeEkPzNTtYfxkc3u6PkzdSn
        qn6JVpwduHWjxbk5fxZEF1c1rsRsmMc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-0ctCn3UpNaqbmZXN2QQ0sw-1; Fri, 25 Jun 2021 15:59:10 -0400
X-MC-Unique: 0ctCn3UpNaqbmZXN2QQ0sw-1
Received: by mail-oi1-f197.google.com with SMTP id s35-20020a05680820a3b029021d9ff07a80so5053156oiw.2
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgS1W0YkxnAj8zzimJEJj0dUofXVg1iWDV0xL3ii1c4=;
        b=HebIrOM/EsWDXGIF6He1Ok6KXcNhqFZWEMgEN0lYweco6OpnsIWRfUFcKkZnSd7GXy
         bIzXYS7kHWQRlh3e9OmEOU8P1myYiovdw+5V2RIQEcE8fWb6ZQO3M1KYXQQQcixdxtlV
         odAoBBr/IdMkWyop9w9RtUwUMrIoHxOevrjF7hC7fTAu67cCvrZ3Of9x6t31wGTIBfdf
         nZRoL/Jo0cpLJ/uiwxqu9At2AxEU2fYQ0KgwNofwrAjyVSHlpI9WOcMmxirNMlsCtWZr
         /9Z6k5TCYiHsB61W7YjY8kym1pI9e3uutsouec0h+MDTaFSVTJvHrGvDrEqNXwmKArti
         QgLQ==
X-Gm-Message-State: AOAM530Bn6ZNNok5p8XEPgs98/WbdWRSQSP7deJpz0LwaumQ27mlLawo
        X/4G6IsDcuQoIX7/wq5iytM9ski0loctyO5H2Dz1ThVeVdyki3yDepzBq7B05dXh6k+OxYxOVms
        H71ZV+fFdjiE7T9kPfTJcbg==
X-Received: by 2002:a05:6830:1e55:: with SMTP id e21mr8941891otj.29.1624651149615;
        Fri, 25 Jun 2021 12:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK16sNuDxGos3d6wDWJs1xw8YcqRzRff8x/NSugHYZvhWkQA++qMFqI3SoPwY6dhVGg3zmTg==
X-Received: by 2002:a05:6830:1e55:: with SMTP id e21mr8941875otj.29.1624651149422;
        Fri, 25 Jun 2021 12:59:09 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r204sm1467374oih.11.2021.06.25.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:59:09 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v5 4/4] fpga: use reimage ops in fpga_mgr_load()
Date:   Fri, 25 Jun 2021 12:58:49 -0700
Message-Id: <20210625195849.837976-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195849.837976-1-trix@redhat.com>
References: <20210625195849.837976-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If the fpga_image_info flags FPGA_MGR_REIMAGE bit is set
swap out the reconfig ops for the reimage ops and do
the load.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c8a6bfa037933..5e53a0508087a 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -419,6 +419,9 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (info->flags & FPGA_MGR_REIMAGE)
+		uops = &mgr->mops->reimage;
+
 	if (info->sgt)
 		return fpga_mgr_buf_load_sg(mgr, info, info->sgt, uops);
 	if (info->buf && info->count)
-- 
2.26.3

