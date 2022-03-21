Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28294E3418
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 00:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiCUXPX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Mar 2022 19:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiCUXPH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Mar 2022 19:15:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43567420B40;
        Mon, 21 Mar 2022 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647903807; x=1679439807;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l5HXWVGfL0h5jEBZyDeoiw3bRlPLm52xB+vqF1vPhRY=;
  b=GGbzUNvIadOFc033m/g5iZsZQrx4aqB/zjDjr0QOIdim/0E4RMpKykgV
   PRmKTGqtaf5PnT5wXAU/+HWnguGx1wEkUbdEyqdJQ1IGogpQ/8SXYusOH
   cOWvH7lr56uXD0mBEtL18Wsqk4Thv0h9Ex2tWYiIJs7cF2gk+O3iSH0/6
   C+K3QMblG9cQHds02spSkUw/f5an94qByWFcwpE50RRINZ4Po7YbYpXzi
   ADNU36chuppbxAhmhSfOESBJuJfV0fKCxiLK5O0ivllfPwx82jQdxOTrK
   QO7FNc/Z7G9JPRkSEbKs6K4B/mlwGIUin96ZmHwV2q5LcLeMXcHGBfUJF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="255231044"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="255231044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 16:03:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="560085847"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 16:03:11 -0700
Date:   Mon, 21 Mar 2022 16:05:19 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tianfei Zhang <tianfei.zhang@intel.com>
cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, rdunlap@infradead.org, corbet@lwn.net
Subject: Re: [PATCH v4 2/2] Documentation: fpga: dfl: add description of
 Feature ID
In-Reply-To: <20220318031654.2130587-3-tianfei.zhang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2203211604590.4191417@rhweight-WRK1>
References: <20220318031654.2130587-1-tianfei.zhang@intel.com> <20220318031654.2130587-3-tianfei.zhang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Thu, 17 Mar 2022, Tianfei Zhang wrote:

> From: Tianfei zhang <tianfei.zhang@intel.com>
>
> This patch adds the description and registration of Feature ID
> in documentation.
>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
> Documentation/fpga/dfl.rst | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..260cac3b7215 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,6 +502,16 @@ Developer only needs to provide a sub feature driver with matched feature id.
> FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
> could be a reference.
>
> +Individual DFL drivers are bound DFL devices based on Feature Type and Feature ID.
> +The definition of Feature Type and Feature ID can be found:
> +
> +https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-ids.rst
> +
> +If you want to add a new feature ID for FPGA DFL feature device, you must use a pull

s/you muse use/submit/

> +request to register a feature ID for DFL. Here is the DFL Feature ID Registry:
> +
> +https://github.com/OPAE/linux-dfl-feature-id
> +
> Location of DFLs on a PCI Device
> ================================
> The original method for finding a DFL on a PCI device assumed the start of the
> -- 
> 2.26.2
>
>
