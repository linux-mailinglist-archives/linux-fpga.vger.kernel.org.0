Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D55A34F5
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Aug 2022 08:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiH0GD6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Aug 2022 02:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiH0GD6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 27 Aug 2022 02:03:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8CC6965;
        Fri, 26 Aug 2022 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661580237; x=1693116237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6VyNM6wCJnNBazFdw4r4StFMUmKXCrrw+dcwd/uWB0=;
  b=Pk4/2puCT68DpR7wFB1rifQg85oN4eQ/mSnOXfuDF+KVG/WD8Hp2W/hR
   g7zIcG9OT0PStd+qqphZXCLfTvjwBn5A6Tg/1WPwAW6J7djt17yVmOJ+b
   jdp2lkDxPdkYug1oDHG1BIN27GTFLGppuy+aeomKLImEgSurmW8xcPpfo
   E+kjYtHrgzpstd0IrIYKY16ZzkUYgmWpLs+g3o4+UuhGncjK9HhqTGuxU
   /uprZ4Ma/FLg5uuLDbBCSVrvfllZPXPLOiZSBlK3AKXhfCtA74XCzNpE8
   zmhfFQebDBKh1ZX3fTSypSwUrzUqj/77ysTvtSr3zK0c4WSqLb+szPFhD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="281607271"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="281607271"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 23:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="938988166"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 23:03:54 -0700
Date:   Sat, 27 Aug 2022 13:54:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Peter Colberg <peter.colberg@intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2] uio: dfl: add IOPLL user-clock feature id
Message-ID: <Ywmxnsz4RjzQICrL@yilunxu-OptiPlex-7050>
References: <20220817213746.4986-1-peter.colberg@intel.com>
 <20220826150116.16014-1-peter.colberg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826150116.16014-1-peter.colberg@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-26 at 11:01:16 -0400, Peter Colberg wrote:
> Add a Device Feature List (DFL) feature id [1] for the configurable
> IOPLL user clock source, which can be used to configure the clock
> speeds that are used for RTL logic that is programmed into the
> Partial Reconfiguration (PR) region of an FPGA.
> 
> The IOPLL user-space driver [2] contains frequency tables [3]
> with the specific user clock frequencies for an implementation.
> 
> For each desired frequency, the table values are produced by calling
> the quartus tool, the same tool that generates the IOPLL RTL logic.
> The quartus tool allows the RTL designer to select different options
> which can affect the table values. The table-driven, user-space
> driver allows for supporting future, modified implementations and
> provides users the ability to modify the IOPLL implementation.
> 
> [1] https://github.com/OPAE/dfl-feature-id
> [2] https://github.com/OPAE/opae-sdk/blob/a494f54a9f0356d0425edbff228f0254a4c70303/libraries/plugins/xfpga/usrclk/fpga_user_clk.c
> [3] https://github.com/OPAE/opae-sdk/blob/a494f54a9f0356d0425edbff228f0254a4c70303/libraries/plugins/xfpga/usrclk/fpga_user_clk_freq.h
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/uio/uio_dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 8f39cc8bb034..69e93f3e7faf 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -46,10 +46,12 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>  
>  #define FME_FEATURE_ID_ETH_GROUP	0x10
>  #define FME_FEATURE_ID_HSSI_SUBSYS	0x15
> +#define PORT_FEATURE_ID_IOPLL_USRCLK	0x14
>  
>  static const struct dfl_device_id uio_dfl_ids[] = {
>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
>  	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
> +	{ PORT_ID, PORT_FEATURE_ID_IOPLL_USRCLK },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> -- 
> 2.28.0
> 
