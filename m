Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731456F8DCC
	for <lists+linux-fpga@lfdr.de>; Sat,  6 May 2023 03:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjEFBzy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 5 May 2023 21:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjEFBzy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 5 May 2023 21:55:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F704C01
        for <linux-fpga@vger.kernel.org>; Fri,  5 May 2023 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683338153; x=1714874153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0STNQOpNzAtTx7SIrjWO6GLo14LliYmRNAJTPnY5spU=;
  b=GewPb/+VUaMqaJjM66lBmmAx5LT0yKLFYe3ifIaM0513ER4jFE9/tP98
   yOV2yR2pY2eXTwz9xYs3S9giaA3HkoBGh9D5GQddlIDbaQQgt3dmn9ShJ
   ZlqyLcGmTCLHf+NsZwltNZtCGhzi4Z4oSI2XwNMfbTnjk81yOIxQlgJJh
   ZKRtYvxLHU3uSBfI6Q/6sOT5D1vlqIsJyHfxTMAwR+czqfr2NwhHSQSjP
   DfFy7yOC/kT1nZ97eFcJoaTKSTC9W5pGlE4hLiAhN4o16UXa+gvUwoXI9
   +3Smv0KJisWMc8PAQrYLBoKer6o0k4hUzGhVbZmwuKA3AnHOThKff/ITK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="346799311"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="346799311"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 18:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="648120399"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="648120399"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 05 May 2023 18:55:51 -0700
Date:   Sat, 6 May 2023 17:56:00 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA MAINTAINERS changes for 6.3-final
Message-ID: <ZFYkMMpovbmoItUS@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit dc70eb868b9cd2ca01313e5a394e6ea001d513e9:

  fpga: bridge: properly initialize bridge device before populating children (2023-04-07 00:10:04 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.3-final-2

for you to fetch changes up to 510acc93aebca559831408f2d864b7f2106e995f:

  dt-bindings: fpga: replace Ivan Bornyakov maintainership (2023-05-06 17:36:42 +0800)

----------------------------------------------------------------
FPGA MAINTAINERS change for 6.3-final

- Ivan hands over Microchip FPGA maintainership duty to Vladimir.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Ivan Bornyakov (2):
      MAINTAINERS: update Microchip MPF FPGA reviewers
      dt-bindings: fpga: replace Ivan Bornyakov maintainership

 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml          | 2 +-
 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml | 2 +-
 MAINTAINERS                                                            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
