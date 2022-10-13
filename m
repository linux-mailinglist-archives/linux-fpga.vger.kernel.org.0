Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F131E5FD6EB
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Oct 2022 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJMJUk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Oct 2022 05:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJMJUi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 13 Oct 2022 05:20:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1964C4;
        Thu, 13 Oct 2022 02:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66438B81D5A;
        Thu, 13 Oct 2022 09:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77366C433C1;
        Thu, 13 Oct 2022 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665652835;
        bh=Q+8IpjjbDGTN1jVf7AqXepJKEJGzNobz/Ltyjku67qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nz82lYSk1BEgj5/KNC3bWc8Vr+I29GuyQYKc4mfyZk+5QkDN0cBwNC+AP8lg1TPhz
         8ulJiZe/tg2HIIH0YyuVVPr5+/brv4au4inzz1JDGOZkkgLjiySIgzSAVqKBKoNb8q
         TnHrm/hdFB51Kb0HeI+W8xvVf+LfmPT2sQHUGz+c=
Date:   Thu, 13 Oct 2022 11:21:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     git@xilinx.com, michal.simek@xilinx.com, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        ronak.jain@xilinx.com, rajan.vaja@xilinx.com,
        abhyuday.godhasara@xilinx.com, harsha.harsha@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, tanmay.shah@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v3 2/2] fpga: zynqmp-fpga: Adds status interface
Message-ID: <Y0fYjyXrMEo6M76k@kroah.com>
References: <20221013090556.741357-1-nava.kishore.manne@amd.com>
 <20221013090556.741357-3-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013090556.741357-3-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 13, 2022 at 02:35:56PM +0530, Nava kishore Manne wrote:
> Adds status interface for zynqmp-fpga, It's a read only interface
> which allows the user to get the Programmable Logic(PL) configuration
> status.
> 
> Usage:
> To read the Programmable Logic(PL) configuration status
>         cat /sys/class/fpga_manager/<fpga>/device/status
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Updated status messages handling logic as suggested by Xu Yilun.
> 
> Changes for v3:
>               - Updated status interface handling logic (Restrict the status
>                 interface to the device-specific instead of handled by the core)
>                 as suggested by Xu Yilun.
> 
>  drivers/fpga/zynqmp-fpga.c | 87 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)

You add sysfs files without a Documentation/ABI/ update as well, which
is not allowed.  Please fix that up for your next submission.

> @@ -95,6 +175,13 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
>  
>  	priv->dev = dev;
>  
> +	/* Add the device attributes */
> +	ret = sysfs_create_group(&dev->kobj, &zynqmp_fpga_attr_group);
> +	if (ret) {
> +		dev_err(dev, "Error creating sysfs files\n");
> +		return ret;
> +	}

You just raced with userspace and lost.  Do not do this, set the default
groups attribute in your platform driver and the driver core will handle
this all for you automatically.

thanks,

greg k-h
