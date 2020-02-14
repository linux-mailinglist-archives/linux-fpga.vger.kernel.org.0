Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBCE15DB40
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Feb 2020 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBNPoj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Feb 2020 10:44:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:13235 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgBNPoj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Feb 2020 10:44:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 07:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="433053187"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 07:44:37 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 0/7] Add compatible value to Intel Stratix10 FPGA manager and service layer
Date:   Fri, 14 Feb 2020 10:00:45 -0600
Message-Id: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add a compatible property value so we can reuse Intel Stratix10 FPGA
manager and service layer drivers on Intel Agilex SoC platform. 

Richard Gong (7):
  dt-bindings: fpga: add compatible value to Stratix10 SoC FPGA manager
    binding
  arm64: dts: agilex: correct FPGA manager driver's compatible value
  fpga: stratix10-soc: add compatible property value for intel agilex
  dt-bindings, firmware: add compatible value Intel Stratix10 service
    layer binding
  arm64: dts: agilex: correct service layer driver's compatible value
  firmware: stratix10-svc: add the compatible value for intel agilex
  firmware: intel_stratix10_service: add depend on agilex

 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt    | 2 +-
 .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt         | 3 ++-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi                         | 4 ++--
 drivers/firmware/Kconfig                                              | 2 +-
 drivers/firmware/stratix10-svc.c                                      | 1 +
 drivers/fpga/stratix10-soc.c                                          | 3 ++-
 6 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.7.4

