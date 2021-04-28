Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB51436D0C9
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Apr 2021 05:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhD1DNe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 23:13:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:18980 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhD1DNe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 23:13:34 -0400
IronPort-SDR: tdoOb3bYQpq8rUZLg0jEalW0acJdThjiGDMaC+2jOgAUW1eq3BGYeFKc9dnlYqyKHVQibee7li
 4znBodYQIihw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="193455007"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="193455007"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 20:12:49 -0700
IronPort-SDR: rs1EmMJ/H/NunbGeVX5vVKN8k1uXcTY4kBtfm+FIktheSAq+i7m2ZRGdJCqSaXJirKAgUXQFba
 xdh9xhtkQ+dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="615873620"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2021 20:12:45 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lbad3-0006uP-8k; Wed, 28 Apr 2021 03:12:45 +0000
Date:   Wed, 28 Apr 2021 11:12:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com
Subject: [RFC PATCH] fpga: xrt: xmgnt_bridge_ops can be static
Message-ID: <20210428031203.GA10476@2bf684b2bf2b>
References: <20210427205431.23896-21-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427205431.23896-21-lizhi.hou@xilinx.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

drivers/fpga/xrt/mgnt/xmgnt-main-region.c:71:30: warning: symbol 'xmgnt_bridge_ops' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 xmgnt-main-region.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/xrt/mgnt/xmgnt-main-region.c b/drivers/fpga/xrt/mgnt/xmgnt-main-region.c
index 398fc816b1786..216f0e9652d47 100644
--- a/drivers/fpga/xrt/mgnt/xmgnt-main-region.c
+++ b/drivers/fpga/xrt/mgnt/xmgnt-main-region.c
@@ -68,7 +68,7 @@ static int xmgnt_br_enable_set(struct fpga_bridge *bridge, bool enable)
 	return rc;
 }
 
-const struct fpga_bridge_ops xmgnt_bridge_ops = {
+static const struct fpga_bridge_ops xmgnt_bridge_ops = {
 	.enable_set = xmgnt_br_enable_set
 };
 
