Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7179662E5C
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Jan 2023 19:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjAISI5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 13:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbjAISI1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 13:08:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC2A2625;
        Mon,  9 Jan 2023 10:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67EFFB80EB9;
        Mon,  9 Jan 2023 18:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A5C433F2;
        Mon,  9 Jan 2023 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673287637;
        bh=axqbfZzhn5xK7WtcjbkruZoOWnVHZi9MAGLiTYIuVOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2U33EJFaZi1MJRk+ts748GXqyReV2PcINbWpLqe7TOJzYMLQ+DTljn77FOdrINzq
         tUpCv14WxPR3MpkyFn5xNBvmjJAGrOdJ2rS5n4FfoZ7O3V82TeSPZTeqRZti1nCc6b
         lFZimA1Heok6xUxYGUXSS2dcjnuyoFc4Z2zw21FmiJgmtaLGTrIgfRNlSKzn2JCNs8
         BQvs+61W1fW+xkVCvTN+VHCu7XyqZI1U67pCyKjU6llyaN6zRNtKygimEmFGocoYMf
         UpI4RjUugtk6iPV5s4UuBYerN4rsDySPAE5k6P1SvrSC/2MPLYT0zE1Z3mxkBEkxAp
         +APHvxBtcGL7Q==
Date:   Mon, 9 Jan 2023 18:07:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/10] mfd: intel-m10-bmc: Rename the local variables
Message-ID: <Y7xXzxqG+9Sv/Nf9@google.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226175849.13056-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 26 Dec 2022, Ilpo Järvinen wrote:

> Local variables directly interact with dev_get_drvdata/dev_set_drvdata
> should be named ddata.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>

It took 2 people to rename some variables? :)

> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 12c522c16d83..2c26203c4799 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -81,15 +81,15 @@ static DEVICE_ATTR_RO(bmcfw_version);
>  static ssize_t mac_address_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	struct intel_m10bmc *ddata = dev_get_drvdata(dev);

In general I'm all for the use of 'ddata' for driver data.

For my own reference (apply this as-is to your sign-off block):
                                                       
Acked-for-MFD-by: Lee Jones <lee@kernel.org>

>  	unsigned int macaddr_low, macaddr_high;
>  	int ret;
>  
> -	ret = m10bmc_sys_read(max10, M10BMC_MAC_LOW, &macaddr_low);
> +	ret = m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
>  	if (ret)
>  		return ret;
>  
> -	ret = m10bmc_sys_read(max10, M10BMC_MAC_HIGH, &macaddr_high);
> +	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
>  	if (ret)
>  		return ret;
>  
> @@ -106,11 +106,11 @@ static DEVICE_ATTR_RO(mac_address);
>  static ssize_t mac_count_show(struct device *dev,
>  			      struct device_attribute *attr, char *buf)
>  {
> -	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
>  	unsigned int macaddr_high;
>  	int ret;
>  
> -	ret = m10bmc_sys_read(max10, M10BMC_MAC_HIGH, &macaddr_high);
> +	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.30.2
> 

-- 
Lee Jones [李琼斯]
