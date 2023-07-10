Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4530474CB68
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 06:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGJEtE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 00:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGJEtE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 00:49:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C891;
        Sun,  9 Jul 2023 21:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688964543; x=1720500543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eb6JbEhigDeJ7Y+hRHEGA9JDUJ8/2Tjqf5gjZrir/Y=;
  b=DSrXlGrMdOQgUVerIZxRtu+V+MQijURJItcpnrPU7Q7oTR2O5xuh3LMK
   R5xtrX4duAonNjpDfhV+dTMgMfxDLS8sGYChPVplcaExokVK3nJCLzF1Y
   rynxd2G4KxVRiKnt8p4XeCulApcNF/9dcAyp7EoL2WEVn5IMqAM/6PEpq
   bDyiNVdfPyQSKyNwLuu5xkWB8PUSbmbgok6er8f5evuE+ubI4M69RNEJe
   UuXbhv4ll0TJjugbmPGwylCk7J7Sf9hMca8pVgK6BDri7VcVcUDefiPs5
   GZHARw4XgaYKo9U0uiOYMLa4c+UKno4R24kukmdy3TPjRgEO5iLeE+EC7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364292600"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364292600"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 21:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="720569045"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720569045"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2023 21:49:01 -0700
Date:   Mon, 10 Jul 2023 12:47:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v8 4/4] fpga: add configuration for the FPGA KUnit test
 suites.
Message-ID: <ZKuNZoXQSv9H2I1k@yilunxu-OptiPlex-7050>
References: <20230630152507.30219-1-marpagan@redhat.com>
 <20230630152507.30219-5-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630152507.30219-5-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-30 at 17:25:07 +0200, Marco Pagani wrote:
> Add configuration for the KUnit test suites for the core components
> of the FPGA subsystem.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>
