Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6825E46A
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIDX6D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgIDX6C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 4 Sep 2020 19:58:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE9C061244;
        Fri,  4 Sep 2020 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FLbweJ5cp/Wfi8knJd+NP5SyzqXzEODUDqD5MHJYO4s=; b=gL+wNqQV1JgDeG6olR49UMgac/
        QW35pPhELqKtWWjpZJTa7pXXsh96gHGTMlCZovdX10zkO7CSBA7FwzVjSORcMZ5U4npoNSKPq1vE2
        tnzqc1WgK15eBRcYEZQoO2qs3O0rwfICCwDTd96bnIXOPryW/ToMoql5rA9VS6u7mBXareUS7/m2r
        4cMkgxIXpMDE7LO57ro1ucxWXn+QtZz14y/wRZ5EF+eQJ2qWFad0izqR2HJKe4CS/uFKDYRpZNG5L
        HYEtZ3Ac7dImDR52BTV4PToKh1G43qeL/b/q0G1laAjgrt2BJR+WRyZIi48LqMTGDhxwKsH8AZ06q
        C+CSENOA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kELaZ-0008TK-4q; Fri, 04 Sep 2020 23:57:51 +0000
Subject: Re: [PATCH v1 01/12] fpga: fpga security manager class driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-2-russell.h.weight@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <733242d1-be39-5f8f-1ed9-8513126e5145@infradead.org>
Date:   Fri, 4 Sep 2020 16:57:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 9/4/20 4:52 PM, Russ Weight wrote:
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 88f64fbf55e3..97c0a6cc2ba7 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -235,4 +235,13 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>  
> +config IFPGA_SEC_MGR
> +	tristate "Intel Security Manager for FPGA"
> +        help

Use one tab instead of spaces to indent "help".

> +	  The Intel Security Manager class driver presents a common
> +	  user API for managing secure updates for Intel FPGA
> +	  devices, including flash images for the FPGA static
> +	  region and for the BMC. Select this option to enable
> +	  updates for secure FPGA devices.
> +
>  endif # FPGA

thanks.
-- 
~Randy

