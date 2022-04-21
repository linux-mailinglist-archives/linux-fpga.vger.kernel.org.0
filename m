Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130B50A4EF
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390440AbiDUQCz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390432AbiDUQCy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 12:02:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627D310FF9;
        Thu, 21 Apr 2022 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650556804; x=1682092804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Km40a1E7MdBXZjMmkalg5GAvHR3jO7GjMsaP0SncP9Q=;
  b=kiqeBEAEMShJWEJrHTZ5Oe8IPWtB0e+oWKUWYiLVd+yYn9rX8tCfIJ9A
   8k5Y37f22Ie221ORenGHR0PVzve2leYPJKSI68pQQNGiSNR4o7gKixwhe
   kd/zu6dPVYXd2qe5tc6l8l321Ie84SsukEqB1C1b330TqNJuGh/rRaQ/H
   EYEHFsoec0v2yUsIreD1kWxFVwoMRZXBN4OlHervEWWmeMMIyEnGVT7/3
   O2tnwOMRX/jIpnj5pvUpraneaZT7sD7UWmIZpdNkQgKDmnmUxwteBodvo
   vuTPu7Y7w8KuGxPFVmeSi9QQnu/ho0YqXU6PXeCLdgfoM5O4pYdqbnJBU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264567203"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="264567203"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 09:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="577313641"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2022 09:00:00 -0700
Date:   Thu, 21 Apr 2022 23:52:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v5 1/5] fpga: zynq: Fix incorrect variable type
Message-ID: <20220421155223.GB347460@yilunxu-OptiPlex-7050>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
 <20220421044744.3777983-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421044744.3777983-2-nava.manne@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 21, 2022 at 10:17:40AM +0530, Nava kishore Manne wrote:
> zynq_fpga_has_sync () API is expecting "u8 *" but the
> formal parameter that was passed is of type "const char *".
> fixes this issue by changing the buf type to "const char *"

  Fix this issue by ...

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>

With the minor fix, Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> Changes for v2:
>                 -None.
> Changes for v3:
>                - Changed arg buf type to "const char *" as suggested by Tom.
>                - update zynq_fpga_has_sync () API description to align with API
>                  functionality.
> Changes for v4:
>                - None.
> 
> Changes for v5:
>                - Dropped the irrelevant doc update changes.
> 
>  drivers/fpga/zynq-fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 426aa34c6a0d..6beaba9dfe97 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
>   * the correct byte order, and be dword aligned. The input is a Xilinx .bin
>   * file with every 32 bit quantity swapped.
>   */
> -static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
> +static bool zynq_fpga_has_sync(const char *buf, size_t count)
>  {
>  	for (; count >= 4; buf += 4, count -= 4)
>  		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
> -- 
> 2.25.1
