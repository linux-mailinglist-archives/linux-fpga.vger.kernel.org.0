Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7543C4C4A34
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Feb 2022 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiBYQLR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Feb 2022 11:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiBYQLQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 25 Feb 2022 11:11:16 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED97D211337
        for <linux-fpga@vger.kernel.org>; Fri, 25 Feb 2022 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645805443; x=1677341443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hJGYy9WhDkNkcUq/4XXIV7GrKljzAX8Pr/wId5/Xbs=;
  b=iMQfbkAV0ldyFiip/5C29OAQmfr8x/cmcQUSBUBoTB0SWdteDlm9qZxc
   I+uFJ7P62B6+qlqqwBXRofUAhCdx4MsgB4nIRnnSyAF6KrcyQlkKlCE/n
   cUuc6iOErCHYpYkJ2iPHquoCnEj+CAH8Cb5JWCvs7Ca3UY2Gdj16fXe9j
   gtqV1kairb7cLmq2DrPf7I60Q0IUuyzUfaWWFS8CIut8iAY7PIXcwjRPt
   voaKKEHFZfjqqpubQ/B+8GxeOK/b9Bux83lXJW43ZaH87ae36CpSrk5JX
   Q/MNxrCyeiQdE8eWPedeLWsrprXtb7pSTH/xGNUs0gnarvWpB4pPrRy6n
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313241586"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="313241586"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:10:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549314858"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 08:10:42 -0800
Date:   Sat, 26 Feb 2022 00:02:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Increase the credit timeout
Message-ID: <20220225160203.GA1377773@yilunxu-OptiPlex-7050>
References: <20220221141127.3765-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221141127.3765-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 21, 2022 at 10:11:27PM +0800, tien.sung.ang@intel.com wrote:
> From: Ang Tien Sung <tien.sung.ang@intel.com>
> 
> Increase the timeout for SDM (Secure device manager) data credits from
> 20ms to 40ms. Internal stress tests running at 500 loops failed with the
> current timeout of 20ms. At the start of a FPGA configuration, the CVP
> host driver reads the transmit credits from SDM. It then sends bitstream
> FPGA data to SDM based on the total credits. Each credit allows the
> CVP host driver to send 4kBytes of data. There are situations whereby,
> the SDM did not respond in time during testing.
> 
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
>  drivers/fpga/altera-cvp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..5295ff90482b 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -52,7 +52,7 @@
>  /* V2 Defines */
>  #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
>  
> -#define V2_CREDIT_TIMEOUT_US		20000
> +#define V2_CREDIT_TIMEOUT_US		40000
>  #define V2_CHECK_CREDIT_US		10
>  #define V2_POLL_TIMEOUT_US		1000000
>  #define V2_USER_TIMEOUT_US		500000

Acked-by: Xu Yilun <yilun.xu@intel.com>

> -- 
> 2.25.1
