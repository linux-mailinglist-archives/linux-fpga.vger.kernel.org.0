Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502A72AE3C
	for <lists+linux-fpga@lfdr.de>; Mon, 27 May 2019 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfE0Fi6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 May 2019 01:38:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:7420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfE0Fi6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 May 2019 01:38:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 22:38:57 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2019 22:38:56 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v3 01/16] fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register address.
Date:   Mon, 27 May 2019 13:22:11 +0800
Message-Id: <1558934546-12171-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
References: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

FME_PR_INTFC_ID is used as compat_id for fpga manager and region,
but high 64 bits and low 64 bits of the compat_id are swapped by
mistake. This patch fixes this problem by fixing register address.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index 76f3770..b3f7eee 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -30,8 +30,8 @@
 #define FME_PR_STS		0x10
 #define FME_PR_DATA		0x18
 #define FME_PR_ERR		0x20
-#define FME_PR_INTFC_ID_H	0xA8
-#define FME_PR_INTFC_ID_L	0xB0
+#define FME_PR_INTFC_ID_L	0xA8
+#define FME_PR_INTFC_ID_H	0xB0
 
 /* FME PR Control Register Bitfield */
 #define FME_PR_CTRL_PR_RST	BIT_ULL(0)  /* Reset PR engine */
-- 
1.8.3.1

