Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3194FE5A4
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Apr 2022 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiDLQPb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Apr 2022 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354249AbiDLQPa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Apr 2022 12:15:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E89496BB;
        Tue, 12 Apr 2022 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649779992; x=1681315992;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0pURC/5Ajvufk1eQ0VJkB+1DSapFf4a+2rnV/faIdBA=;
  b=QHzk5lDHa3Gy5vW9brOXVFLAyr33b/9JVYRwtSRHgPMoJHmiHCHkQBN4
   TWkYcdNnBkWKoEmqzh2wFI8Qw9O3EWbqHq6VtX8HR9MnTKWZZgQ0HddFW
   uJBIQ6nU6JfiKAl1dTZ2UnVUlUfc49H7v6y4ERBM4nU2NXaYr8yiRwxJC
   A68BwMpF7o81nynYxd3mVcAEF2R+pdV9fVHaQqOPwyvbXdywfVXjQphci
   xCJG6LGSVGNdO/1agJQhAK8sGybu2dtji9yZI2OjHzsHMS3bxxmv6f1zW
   B1b1vSdexfu9lUBd/3OQbdxEISqQ6VJmnXFJG+JjdDWH4sy9h+e849SoI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="348852258"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="348852258"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:06:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="572823362"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:06:34 -0700
Date:   Tue, 12 Apr 2022 09:08:45 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tianfei Zhang <tianfei.zhang@intel.com>
cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, rdunlap@infradead.org, corbet@lwn.net
Subject: Re: [PATCH v6 2/2] Documentation: fpga: dfl: add description of
 feature ids
In-Reply-To: <20220412061705.53721-3-tianfei.zhang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2204120908150.278492@rhweight-WRK1>
References: <20220412061705.53721-1-tianfei.zhang@intel.com> <20220412061705.53721-3-tianfei.zhang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 12 Apr 2022, Tianfei Zhang wrote:

> From: Tianfei zhang <tianfei.zhang@intel.com>
>
> This patch adds the description of feature id table in documentation.
>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>

Hi Tianfei,

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v6: fix documentation from Hao's comment.
> v5: fix documentation from Matthew's comment.
> ---
> Documentation/fpga/dfl.rst | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..15b670926084 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature driver with matched feature id.
> FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
> could be a reference.
>
> +Please refer to below link to existing feature id table and guide for new feature
> +ids application.
> +https://github.com/OPAE/dfl-feature-id
> +
> +
> Location of DFLs on a PCI Device
> ================================
> The original method for finding a DFL on a PCI device assumed the start of the
> -- 
> 2.26.2
>
>
