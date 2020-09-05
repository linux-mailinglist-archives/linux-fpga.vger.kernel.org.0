Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8944B25E473
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 02:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgIEABX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 20:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgIEABV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 4 Sep 2020 20:01:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D2C061244;
        Fri,  4 Sep 2020 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=VGmzSzybPDxBo1GQhqC5WtUexOVHfNZtTn4eHNI32pM=; b=aRbQajh6sdmCMv6FDctdlZS2PG
        W+Kay5KphUiy682XMaZd9c0bv0QQHhKEocCDvyvO+6XthN0IrtY/BgndUMWFOalF+2CfIJ0FzE8cu
        xYekFwGK886Pbvefs8ahndjt4bENoDN9//d/olsVFz3vPDezo6VJYYz9GCv5f5Eils+yn8yYop9p6
        0Dgb84pR8YRBmWoALCX9sdi1P8Eng/ZqqFeKtBcPYwAHxcztP/kjwYmHzL5I4ZKW+P6BotKu19YJc
        lFhtz3fz8/jCHnwDsWC2LWMAgtiDbH/JpBunij8oKsDjxH6Wq8O1LC+sb9RM6s4AhNz8CqmbScnnz
        mXdLBtvw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kELds-0000Di-Lj; Sat, 05 Sep 2020 00:01:16 +0000
Subject: Re: [PATCH v1 02/12] fpga: create intel max10 bmc security engine
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-3-russell.h.weight@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d0b74ad9-5bdb-4085-83f2-1008471eba41@infradead.org>
Date:   Fri, 4 Sep 2020 17:01:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 9/4/20 4:52 PM, Russ Weight wrote:
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 97c0a6cc2ba7..0f0bed68e618 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -244,4 +244,15 @@ config IFPGA_SEC_MGR
>  	  region and for the BMC. Select this option to enable
>  	  updates for secure FPGA devices.
>  
> +config IFPGA_M10_BMC_SECURE
> +        tristate "Intel MAX10 BMC security engine"
> +	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
> +        help
> +          Secure update support for the Intel MAX10 board management
> +	  controller.

Please consistently use one tab to indent Kconfig keywords (tristate, depends, help)
and one tab + 2 spaces to indent help text.
(as in Documentation/process/coding-style.rst)

> +
> +	  This is a subdriver of the Intel MAX10 board management controller
> +	  (BMC) and provides support for secure updates for the BMC image,
> +	  the FPGA image, the Root Entry Hashes, etc.
> +
>  endif # FPGA


thanks.
-- 
~Randy

