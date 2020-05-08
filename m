Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A822D1CB6F5
	for <lists+linux-fpga@lfdr.de>; Fri,  8 May 2020 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHSTD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 8 May 2020 14:19:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:49234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgEHSTD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 8 May 2020 14:19:03 -0400
IronPort-SDR: 4gap54/c3/wJ2YMABrGV5VFMhjJPubJCXmSCLa77noz3fRhPMLuDN179NcycSKokBYMnTZLI5P
 oz+38AVacMBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 11:19:02 -0700
IronPort-SDR: xlG+pLTjJtooALYiHtqcjda0K1mogzg/hqYZSjlOPN4zE8NGrkTayHKqmNGQq3VnJFUXwHxF64
 dDrDtRvAHXzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="297033545"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga008.jf.intel.com with ESMTP; 08 May 2020 11:19:02 -0700
Date:   Fri, 8 May 2020 11:20:50 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
cc:     Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: Replace zero-length array with
 flexible-array
In-Reply-To: <20200507185256.GA14313@embeddedor>
Message-ID: <alpine.DEB.2.21.2005081119420.7209@rhweight-WRK1>
References: <20200507185256.GA14313@embeddedor>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



This looks like a a good change to me.

Tested-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

On Thu, 7 May 2020, Gustavo A. R. Silva wrote:

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>        int stuff;
>        struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> drivers/fpga/dfl.h |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 9f0e656de720..1cd51ea52ce1 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -235,7 +235,7 @@ struct dfl_feature_platform_data {
> 	unsigned long dev_status;
> 	void *private;
> 	int num;
> -	struct dfl_feature features[0];
> +	struct dfl_feature features[];
> };
>
> static inline
>
>
