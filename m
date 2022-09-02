Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63C35AB703
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Sep 2022 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiIBQ5M (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Sep 2022 12:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiIBQ5L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Sep 2022 12:57:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE2F4936;
        Fri,  2 Sep 2022 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662137831; x=1693673831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=deLXIfLV/MTOXO/RjhFmo9+ac3sNfua/QFjbys5zc0E=;
  b=HSY+qcBzXpshPdwpK6mjGCAF3hVXgBYSMGrVxy+gVclbRGTnRc639M2/
   dff+sfoAlhcIadQGLelYkuSDWE7Kk415zCvHe5FT44BkGBlHTR1LUrvh2
   jnZivSpB59ceWOHgqi5LSilK5uoPR43HaYeHG/NFgh7IAb6+puE1a4v0b
   8kyd5fwuW8Z3/Z9TEoFqIrSQzM+O69KOvGk/icNtTEpT2R2PmRhcmDZaP
   mzgPo/leQq1kZnnW1ftxgupmdKz3T5rCNiWSL6r4IIhb9lOuv0ujpJVCG
   wFq17sowebC686nwkIeANXZCBjySw7rClFsNoa70UqIPSw33pKdeKJfuN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382321114"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382321114"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 09:57:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="646170183"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.55.214])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 09:57:10 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, lee@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, marpagan@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 0/2] fpga: dfl: support d5005 secure updates
Date:   Fri,  2 Sep 2022 09:57:04 -0700
Message-Id: <20220902165706.518074-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The MAX10 secure update driver currently supports only the N3000. With
these two patches secure updates are also supported for the D5005. A
different driver name is used for the D5005 vs the N3000 to facilitate
future conditional code that is based on device type.

Russ Weight (2):
  mfd: intel-m10-bmc: add d5005 bmc secure update driver
  fpga: m10bmc-sec: d5005 bmc secure update driver

 drivers/fpga/intel-m10-bmc-sec-update.c | 3 +++
 drivers/mfd/intel-m10-bmc.c             | 1 +
 2 files changed, 4 insertions(+)

-- 
2.25.1

