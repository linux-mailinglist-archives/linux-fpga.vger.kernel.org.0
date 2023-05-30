Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04FD71552A
	for <lists+linux-fpga@lfdr.de>; Tue, 30 May 2023 07:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjE3FuG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 May 2023 01:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjE3FuD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 May 2023 01:50:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E77E5
        for <linux-fpga@vger.kernel.org>; Mon, 29 May 2023 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425802; x=1716961802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bEev6BEAEKINhgh1SGWYhdl0Bb+sPVAmVHoIRZK5MbI=;
  b=nzubE8fqnwCAELa3rViik5P3ej0mq2QN0b6e1QyPotWBX6NNbWyXD4bu
   pfxmahuXQFZBUK979H8v+3RNpnMaA5Sthl2LtFdp+pKQj0DkfBb61T5Tm
   Yp32KTybM4sXtPJTo8BL87Uaa6ezUffF7eW9n9vSpaLSvC3xQPY2T/ric
   xK3LShtOV5yqh0YDZKHTONRzeUJ020Bsl26wToFEwADWT6vYhY/RQBI++
   eZjaPLDcyB+W27WuAsD7BD6yu+gdo8JqSRaZucWvAvgNeMg1DPCwCfPfv
   3PdPgBY3pLRx44ZmESCTPVCNCInOkK1TqYXgZg6LOQ2+pC/RrlwJI+biX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420581538"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420581538"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="952982474"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="952982474"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2023 22:50:00 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH 0/2] Microchip FPGA MAINTAINERS changes
Date:   Tue, 30 May 2023 21:49:34 +0800
Message-Id: <20230530134936.634370-1-yilun.xu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Rebased against Linux 6.4-rc3 and resend.

Ivan Bornyakov (2):
  MAINTAINERS: update Microchip MPF FPGA reviewers
  dt-bindings: fpga: replace Ivan Bornyakov maintainership

 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
 .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
 MAINTAINERS                                                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

