Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92E8503782
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiDPQ2W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 12:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiDPQ2U (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 12:28:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D92ED67
        for <linux-fpga@vger.kernel.org>; Sat, 16 Apr 2022 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650126348; x=1681662348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/mdB7VGAJUBnhGVl9Ng5vHD4Fg6XvCfzw3p2GJnuho=;
  b=B1WmbQ6ZRTaJV4vnyNN1KUFtr3pOnqILC6lzWHu7eAiU4rOiMf0/THOF
   8xEC5jF0qzNBC7UsvYpP6KsQGmM3F3mKGTmhWYJsFXlu0Cj5PgK9MZRlp
   6pqm/ZLtK96/0Wg3LILNYRG4N6P9iz/HkqcIiy0bPQXjx2PThcfMtQn8V
   hqFtXO7Ac8Nbyd0p/z7nyS0QDoczc/o3VfeCZ4u308UNw8L28/isiltad
   YGRO2GNtmD4gbynVRpS7RM2e8vxfDNJz5kdTF18cKDUybSTLhMZFV2MqT
   zLPRx7Fqa+ctmT3ChT2+AiowJNHK1GlS8Km/I11vPL5bDPz1ZrwZST1VK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263479281"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="263479281"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 09:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="553595101"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 16 Apr 2022 09:25:45 -0700
Date:   Sun, 17 Apr 2022 00:18:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
Message-ID: <20220416161814.GC301222@yilunxu-OptiPlex-7050>
References: <20220413091519.317735-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413091519.317735-1-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Apr 13, 2022 at 05:15:19AM -0400, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are not
> connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack device),
> PORT DFLs are connected to FME DFL directly, so we don't need to search
> PORT DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
> (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for that
> port.
> 
> Link: https://lore.kernel.org/linux-fpga/20220316070814.1916017-2-tianfei.zhang@intel.com/
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 7 +++++++
>  drivers/fpga/dfl.h     | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 717ac9715970..6347f31058f0 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -259,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>  			 */
>  			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bar >= PCI_STD_NUM_BARS ||
> +			    bar == FME_PORT_OFST_BAR_SKIP) {

Seems the second judgement will never be triggered?

Thanks
Yilun

> +				dev_dbg(&pcidev->dev, "skipping search DFL for port %d on BAR %d\n",
> +					i, bar);
> +				continue;
> +			}
> +
>  			start = pci_resource_start(pcidev, bar) + offset;
>  			len = pci_resource_len(pcidev, bar) - offset;
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 53572c7aced0..e0f0abfbeb8c 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -91,6 +91,7 @@
>  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
>  #define FME_HDR_BITSTREAM_ID	0x60
>  #define FME_HDR_BITSTREAM_MD	0x68
> +#define FME_PORT_OFST_BAR_SKIP	7
>  
>  /* FME Fab Capability Register Bitfield */
>  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric version ID */
> -- 
> 2.26.2
