Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74409536C70
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 12:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiE1K5G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 06:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiE1K5F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 06:57:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA31CFC9;
        Sat, 28 May 2022 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653735425; x=1685271425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d27SPm0THgqa4HwCRNhy6NUMdCCR6h7O62QWOQ2LWF8=;
  b=ZJeK3MZN6TdqU/qVNuo03VaYc4V/druOOFbWt6er2GF6KJp3FUiNOjNk
   3o3Fm0FLTExVUWR4qpOG7qspO+mw/E/SNtZI4+W98SeVW+4VPbdm5z1ID
   SoUcOhMFfwsmGaF1O5FkuoIbUW/Tr/+FaT5aNekgiuuvvTGNPvPwGejRO
   gLIYgeVPtwMXj1MGD56pra7A1KTSrtWzSKUfUBSAVB28TiFzJ0JAFwlBE
   tu7CDsvl3Gx+fV3Yhb83p9W8SeQ9EomQwpfJo0WVL4nZyyfL/NFzpdZXh
   eckR+2voFX9+sJPyZv2HkJsEVPzTqum5xq8nKmxR0FEqPiQ5Qte8RhhVx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="361045106"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="361045106"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 03:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="604365289"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2022 03:57:01 -0700
Date:   Sat, 28 May 2022 18:49:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        tianfei.zhang@intel.com
Subject: Re: [PATCH 2/3] fpga: dfl: Fix kernel-doc warnings in
 include/linux/dfl.h
Message-ID: <20220528104918.GB178479@yilunxu-OptiPlex-7050>
References: <20220519221249.858873-1-basheer.ahmed.muddebihal@linux.intel.com>
 <20220519221249.858873-3-basheer.ahmed.muddebihal@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519221249.858873-3-basheer.ahmed.muddebihal@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 19, 2022 at 03:12:48PM -0700, Basheer Ahmed Muddebihal wrote:
> Fixed the following warnings:
> include/linux/dfl.h:21: warning: Enum value 'FME_ID' not described in enum 'dfl_id_type'
> include/linux/dfl.h:21: warning: Enum value 'PORT_ID' not described in enum 'dfl_id_type'
> include/linux/dfl.h:21: warning: Enum value 'DFL_ID_MAX' not described in enum 'dfl_id_type'
> include/linux/dfl.h:47: warning: Function parameter or member 'revision' not described in 'dfl_device'
> 
> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> ---
>  include/linux/dfl.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 431636a0dc78..4caa2d99d8dc 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -13,6 +13,9 @@
>  
>  /**
>   * enum dfl_id_type - define the DFL FIU types
> + * @FME_ID: dfl id for FPGA Management Engine node.

DFL FIU type for FPGA Management Engine. Is it better?

> + * @PORT_ID: dfl id for Port.

DFL FIU type for Port.

> + * @DFL_ID_MAX: maximum number for dfl ids.

number of valid DFL FIU types.

>   */
>  enum dfl_id_type {
>  	FME_ID = 0,
> @@ -27,6 +30,7 @@ enum dfl_id_type {
>   * @id: id of the dfl device.
>   * @type: type of DFL FIU of the device. See enum dfl_id_type.
>   * @feature_id: feature identifier local to its DFL FIU type.
> + * @revision: feature revision local to its DFL FIU type.

Local to its DFL FIU type? Every feature manages it's own revesion, is
it?

Thanks,
Yilun

>   * @mmio_res: mmio resource of this dfl device.
>   * @irqs: list of Linux IRQ numbers of this dfl device.
>   * @num_irqs: number of IRQs supported by this dfl device.
> -- 
> 2.34.1
