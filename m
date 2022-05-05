Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94951B5ED
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 04:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiEEC1R (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 May 2022 22:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiEEC1R (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 May 2022 22:27:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2504BFD0;
        Wed,  4 May 2022 19:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651717419; x=1683253419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wA6x1/zwYLOPI3LiA5XZehsRzpeivSsd5DiD94s7U7s=;
  b=P8Nflcl5kfkF6DcrOp4zeVmliUxFYSePJE7SqUgrbDcLtycKOdu3wrOD
   TgKb6I/JVuG9DQFT+FE0VxbTjsX088zGqKqlVvocgiA8bcyfAvWtG/Syx
   wV7RGqkm65FijuIvDI+J2JXm6JzU9pz51p5Bc0kL2zEBePuftRGwG/CiT
   sIzVpHwuY9YetKEceeOI0snAm8QAXEdtcd/cbbFtPOf0PoDabQKA3fJCW
   B9mOaUshgMyO61yB5PgPxDhJgHFXJkHiOQKdu7iKO5d41Tfxn8E0y4xAs
   0YS72goyyaNrCeQdDH7Mhzjoi85fDeuON2PbmjHYa8CWII0BTDrka/dhh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265556721"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="265556721"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 19:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="734683186"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2022 19:23:37 -0700
Date:   Thu, 5 May 2022 10:15:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v4] uio: dfl: add HSSI subsystem feature id
Message-ID: <20220505021545.GA417720@yilunxu-OptiPlex-7050>
References: <20220505001628.681226-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505001628.681226-1-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 04, 2022 at 08:16:28PM -0400, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add the Device Feature List (DFL) feature id for the
> High Speed Serial Interface (HSSI) Subsystem to the
> table of ids supported by the uio_dfl driver.
> 
> The HSSI Subsystem is a configurable set of IP blocks
> to be used as part of a Ethernet or PCS/FEC/PMA pipeline.
> Like the Ethernet group used by the N3000 card, the HSSI
> Subsystem does not fully implement a network device from
> a Linux netdev perspective and is controlled and monitored
> from user space software via the uio interface.
> 
> The Feature ID table of DFL can be found:
> https://github.com/OPAE/dfl-feature-id
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>

Please re-order the tags. The earliest at the top and the latest at the
bottom.

"SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author."

For more details, please refer to Documentation/process/submitting-patches.rst


For you case, I assume:

  Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
  Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
  Reviewed-by: Tom Rix <trix@redhat.com>
  Acked-by: Xu Yilun <yilun.xu@intel.com>

is it?

Thanks,
Yilun


> ---
> v4: add Reviewed-by and Acked-by tag and add Feature ID table url in git message.
> v3: change the name of this feature id to HSSI_SUBSYS and rewrite
>     the git message.
> v2: add HSSI introduction and the git repo of Feature ID table.
> ---
>  drivers/uio/uio_dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 89c0fc7b0cbc..8f39cc8bb034 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>  }
>  
>  #define FME_FEATURE_ID_ETH_GROUP	0x10
> +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
>  
>  static const struct dfl_device_id uio_dfl_ids[] = {
>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> -- 
> 2.26.2
