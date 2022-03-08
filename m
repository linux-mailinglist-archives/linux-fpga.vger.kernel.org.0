Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E34D2379
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 22:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350512AbiCHVkA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 16:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346820AbiCHVj7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 16:39:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868464AE21;
        Tue,  8 Mar 2022 13:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=haGVPFLb5RbFML4STXJpNFdCn/G7G9UQm5pnNjHUCeo=; b=Za9C6SfePSZ43Jjj3xzO9SQm2q
        EoFFZENGFBz+cILk5PDpv86xfM2MZlhisjuTPkbe1UkcbzYz15dPeCK9fJ4MkVV54yYwtJUMhDipc
        Ml2pzSzXrFckSslLf6Vn9HJMR2YNxhBrwO9sEvSNm+asWL2MiEwd4pwLy3xc1gLd/LTsvmpFyo2xO
        v0s84VvKN2/d6lG8sJsPIAkoBOvUPKmocZcDJFQWE7ijDI4LMyHaOIfdnJwJ5yAkPeX69tx72OL13
        0faZiyaD82bPf1vXjVFY/qur8FeDCWS2hsntSGVtzkoOEgKfIneSciCtOONC2U+/5SPLyMlnd3QpR
        FsTGXSBQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRhXd-00GYiz-7R; Tue, 08 Mar 2022 21:38:49 +0000
Message-ID: <f28c49a8-4e5a-5601-4d0b-05d34024779f@infradead.org>
Date:   Tue, 8 Mar 2022 13:38:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 4/6] fpga: fpga-mgr: Add missing kernel-doc description
Content-Language: en-US
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
 <20220308094519.1816649-5-nava.manne@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220308094519.1816649-5-nava.manne@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi--

On 3/8/22 01:45, Nava kishore Manne wrote:
> Fixed the warnings: Function parameter or member 'xxx' not
> described.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/fpga-mgr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index a699cc8e2fa6..354789740529 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -730,6 +730,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>   * @parent:	fpga manager device from pdev
>   * @info:	parameters for fpga manager
>   *
> + * @return:  fpga manager pointer on success, negative error code otherwise.

Not quite. Should be:

 * Return: foo bar blah

> + *
>   * This is the devres variant of fpga_mgr_register_full() for which the unregister
>   * function will be called automatically when the managing device is detached.
>   */
> @@ -763,6 +765,8 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
>   *
> + * @return:  fpga manager pointer on success, negative error code otherwise.

ditto.

> + *
>   * This is the devres variant of fpga_mgr_register() for which the
>   * unregister function will be called automatically when the managing
>   * device is detached.

thanks.
-- 
~Randy
