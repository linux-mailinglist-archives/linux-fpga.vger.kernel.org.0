Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8C39FC7A
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhFHQ1z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 12:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231947AbhFHQ1z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 12:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623169561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qViXgyeh1dlyqh22Awn1t3CyyorftxIelVJ9ElQQ5YY=;
        b=Pk6X2DE99bOV29E/nG9AuhXiSdtuYnuGkEnFk8vL54h1ZBp1zHxyCi+pq2RTl7okdb9dx4
        rjI5u4XOfnz00xDv7nHVjqdcy1XDLXJLcryfPoqwHYRquEbNrPuh5dsFBW4ECeZEJDQIfS
        HyQTVZytZlFX8BNbmFCxPpKgu5wncIQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-YMs5n-ucMkmuLgIkyghCMw-1; Tue, 08 Jun 2021 12:26:00 -0400
X-MC-Unique: YMs5n-ucMkmuLgIkyghCMw-1
Received: by mail-ot1-f70.google.com with SMTP id c10-20020a9d75ca0000b02903f63362f6f3so1301635otl.1
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 09:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qViXgyeh1dlyqh22Awn1t3CyyorftxIelVJ9ElQQ5YY=;
        b=cd7DBP8wv72ISjgbrjmDKnJ6Cgk5pdethd4adHJqb3xow7sZpdcTwoBc74RGuiTX8M
         LoWOlDxyMYI1XD5yEh5uhQ4eHocrZesSTOee4rtphkA9ukWU9W4bqMPr2madLuUSG2DL
         LU61zZR+9cYIgO/Z7junjTzh03UzyinCODPiOnmRIYJRKw9EfJjdmIUYg4RxCCNT9Wz/
         wkPrEIKTM+al8roRe9awHIhIzZ76ZeNrvei/N2pNZH7Q2/bwjFuwCiQtPL1kCv2AGOxF
         Z8wD/Icn0Kz6TKSm28HKyNFm5sgJrH30b7BZxQXoYvjFL4nSt3BqR46bLR2/44uqlddR
         uaFA==
X-Gm-Message-State: AOAM532P0uCVtRykR6yFzZjTRY2XYmxc4NcgVLf51ejnUxklAVKcRIik
        Zzm6Q8rkE8gw/X2mhrwG1/24tU03Neov4r/8HdtNtp/0zHebon8lNyh0sW20FojpZ2bulgstbH+
        JUDF7KudE+IFO6tk9qK29Cw==
X-Received: by 2002:a05:6808:128a:: with SMTP id a10mr3395844oiw.161.1623169558853;
        Tue, 08 Jun 2021 09:25:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdkIBlwY+O+Je+hrmiURYYe8KcG1gsS80R38FWHS4/03wkKj44epRlChJ09Yaxd9P5lAXdKw==
X-Received: by 2002:a05:6808:128a:: with SMTP id a10mr3395828oiw.161.1623169558739;
        Tue, 08 Jun 2021 09:25:58 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b26sm2831550otf.69.2021.06.08.09.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:25:58 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, michal.simek@xilinx.com, nava.manne@xilinx.com,
        gregkh@linuxfoundation.org, luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 6/7] fpga: xilinx: remove xilinx- prefix on files
Date:   Tue,  8 Jun 2021 09:25:51 -0700
Message-Id: <20210608162551.3010533-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

It is not necessary to have a xilinx- prefix on a file
when the file is in a xilinx/ subdir.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xilinx/Makefile                                  | 4 ++--
 drivers/fpga/xilinx/{xilinx-pr-decoupler.c => pr-decoupler.c} | 0
 drivers/fpga/xilinx/{xilinx-spi.c => spi.c}                   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/fpga/xilinx/{xilinx-pr-decoupler.c => pr-decoupler.c} (100%)
 rename drivers/fpga/xilinx/{xilinx-spi.c => spi.c} (100%)

diff --git a/drivers/fpga/xilinx/Makefile b/drivers/fpga/xilinx/Makefile
index 7bb7543412790..4ac727d03e140 100644
--- a/drivers/fpga/xilinx/Makefile
+++ b/drivers/fpga/xilinx/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_XILINX_PR_DECOUPLER) += xilinx-pr-decoupler.o
-obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += xilinx-spi.o
+obj-$(CONFIG_XILINX_PR_DECOUPLER) += pr-decoupler.o
+obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA) += zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA) += zynqmp-fpga.o
 
diff --git a/drivers/fpga/xilinx/xilinx-pr-decoupler.c b/drivers/fpga/xilinx/pr-decoupler.c
similarity index 100%
rename from drivers/fpga/xilinx/xilinx-pr-decoupler.c
rename to drivers/fpga/xilinx/pr-decoupler.c
diff --git a/drivers/fpga/xilinx/xilinx-spi.c b/drivers/fpga/xilinx/spi.c
similarity index 100%
rename from drivers/fpga/xilinx/xilinx-spi.c
rename to drivers/fpga/xilinx/spi.c
-- 
2.26.3

