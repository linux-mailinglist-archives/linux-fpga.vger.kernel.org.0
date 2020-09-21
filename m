Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7171271A6D
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Sep 2020 07:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIUFf4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Sep 2020 01:35:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:9101 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUFf4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Sep 2020 01:35:56 -0400
IronPort-SDR: Nz968V6yq3uTqakQyzaGOECZvre1e+ClxfLlVvS1l2hEeC5bo7ZrJE3W5PbFRkyDxxUpEUUJSF
 jqLAkQ9KNBZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="148064993"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="148064993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 22:35:55 -0700
IronPort-SDR: cSeVFHe58QsCAOZM5EbrXpbEOVc5a8wi/rWmrVaIl2Asza06QRg+FwyCbst0xgpwyAWemNPzIH
 6/yGZ/YYkA1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="334240007"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2020 22:35:53 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     krzk@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, lgoncalv@redhat.com
Subject: [PATCH v3] add the FPGA Device Feature List (DFL) EMIF support
Date:   Mon, 21 Sep 2020 13:31:19 +0800
Message-Id: <1600666280-25651-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The driver supports the EMIF controller on Intel Programmable
Acceleration Card (PAC). The controller manages the on-board memory of
the PCIe card.


Hi Moritz:

I have sent 2 versions of the patch to Krzysztof who maintains the
drivers/memory folder. And because this patch depends on the previous
fpga patchset "Modularization of DFL private feature drivers" &
"add dfl bus support to MODULE_DEVICE_TABLE()", it cannot be applied
independently to Krzysztof's branch until next cycle. So he suggests,
"please send a v3 of this patch with the fix above and let's apply it
via Moritz's tree."

So could you help do that? After it got the acked-by from Krzysztof.

Thanks,
Yilun


Xu Yilun (1):
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   2 +
 drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 drivers/memory/dfl-emif.c

-- 
2.7.4

