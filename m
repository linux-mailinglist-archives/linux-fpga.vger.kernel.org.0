Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D585874A5EB
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Jul 2023 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGFVak (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Jul 2023 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGFVak (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Jul 2023 17:30:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07116DD;
        Thu,  6 Jul 2023 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=P3Xuz8GELhidqUWZPKJGYu1EEf8xRrAUuqFDiYa20Q8=; b=sGzArAHOcn5houvQZ2a+lrpen4
        0HGYVnjMLS5ao9ND1Sjj7pKfwOrEV9CrHKVrbdozHgjxcBmjnbmcABaYGnZGEhZuwKk3MAE9pGB/D
        lssWql6M6JuK4YsIhfWhXHtaTi8lnjtjq7VPqIL7TIblYv9RBRC7xT0T3XP78mInyCud4Aa9yj9Vk
        Zyql8PpxbZkXftg95KLpqS4lERtnQhUcfjJSZ3/Prwun4IFDsDLuMEVO7QOeI+ewKjQc1D4iD1ra2
        RYc3G9GekKWqdsMAczUvAP8rXF0t+uf/La+96SNomP73JjMPZxuthE0zdV8zZwvsV5m1lYwVkmrNy
        EaELAxqQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHWYc-002jaa-2e;
        Thu, 06 Jul 2023 21:30:34 +0000
Message-ID: <e5dae9f1-8492-3046-f694-80d13c9927e9@infradead.org>
Date:   Thu, 6 Jul 2023 14:30:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 1/2] fpga: region: fix kernel-doc
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20230706142755.124879-1-marpagan@redhat.com>
 <20230706142755.124879-2-marpagan@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230706142755.124879-2-marpagan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi--

On 7/6/23 07:27, Marco Pagani wrote:
> - Fix the following warnings issued by the kernel-doc script:
> 
> drivers/fpga/fpga-region.c:46: warning: No description found for return value of 'fpga_region_get'
> drivers/fpga/fpga-region.c:97: warning: No description found for return value of 'fpga_region_program_fpga'
> drivers/fpga/fpga-region.c:295: warning: No description found for return value of 'fpga_region_init'
> 
> - Remove the "and registers a reconfig notifier" part from the description
>   of fpga_region_init() since it does not register an of_overlay notifier
>   anymore.
> 
> - Remove the outdated "if @np is not an FPGA Region" case from the return
>   description of fpga_region_get() and replace it with the case when
>   try_module_get() fails.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/fpga/fpga-region.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index ccf6fdab1360..c9d065a6961b 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -38,9 +38,10 @@ EXPORT_SYMBOL_GPL(fpga_region_class_find);
>   *
>   * Caller should call fpga_region_put() when done with region.
>   *
> - * Return fpga_region struct if successful.
> - * Return -EBUSY if someone already has a reference to the region.
> - * Return -ENODEV if @np is not an FPGA Region.
> + * Return:
> + * * fpga_region struct if successful.
> + * * -EBUSY if someone already has a reference to the region.
> + * * -ENODEV if can't take parent driver module refcount.
>   */
>  static struct fpga_region *fpga_region_get(struct fpga_region *region)
>  {
> @@ -91,7 +92,7 @@ static void fpga_region_put(struct fpga_region *region)
>   * The caller will need to call fpga_bridges_put() before attempting to
>   * reprogram the region.
>   *
> - * Return 0 for success or negative error code.
> + * Return: 0 for success or negative error code.
>   */
>  int fpga_region_program_fpga(struct fpga_region *region)
>  {
> @@ -288,8 +289,9 @@ static void fpga_region_dev_release(struct device *dev)
>  }
>  
>  /**
> - * fpga_region_init - init function for fpga_region class
> - * Creates the fpga_region class and registers a reconfig notifier.
> + * fpga_region_init - creates the fpga_region class.
> + *
> + * Return: 0 on success or ERR_PTR() on error.
>   */
>  static int __init fpga_region_init(void)
>  {

-- 
~Randy
