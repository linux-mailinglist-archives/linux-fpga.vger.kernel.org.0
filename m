Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22422D99E8
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 15:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440057AbgLNOU7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 09:20:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:65447 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440056AbgLNOU6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:20:58 -0500
IronPort-SDR: TvwxmeCdYGd/VT6I8Gu0/MICmoA6AKRvuII0MBrQEj/bfseC0JIcl0LIWjzjW6NTi+6zBxS1Hq
 3qBAp29Vf31g==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="173941496"
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="173941496"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:19:08 -0800
IronPort-SDR: S0b5c3Yhr5jCSd2P9wsG7Bs8Gpnb4BptKZ3K9jklyANG3EtlyFxu+xa+KNDRbq2bV1sNkw+gSG
 0eFg0W+/i/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="333456263"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2020 06:18:48 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv2 4/5] dt-bindings: fpga: add authenticate-fpga-config property
Date:   Mon, 14 Dec 2020 08:39:59 -0600
Message-Id: <1607956800-28476-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
References: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property for FPGA bitstream authentication,
which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: put authenticate-fpga-config above partial-fpga-config
    update commit messages
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index e811cf8..d0d3234 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -182,6 +182,7 @@ Optional properties:
 	This property is optional if the FPGA Manager handles the bridges.
         If the fpga-region is  the child of a fpga-bridge, the list should not
         contain the parent bridge.
+- authenticate-fpga-config : boolean, set if do bitstream authentication only.
 - partial-fpga-config : boolean, set if partial reconfiguration is to be done,
 	otherwise full reconfiguration is done.
 - external-fpga-config : boolean, set if the FPGA has already been configured
-- 
2.7.4

