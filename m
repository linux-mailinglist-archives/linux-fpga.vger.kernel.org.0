Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB8820E6
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Aug 2019 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfHEP43 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Aug 2019 11:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEP43 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Aug 2019 11:56:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17D02064A;
        Mon,  5 Aug 2019 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565020588;
        bh=b34+7fFFBV6Sl83qHgsbIEEvlBq8yODr8I5dgk506VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gx8rSdgXwQ4EAIb0kEn2RP7fMh9bOo+Oqpxe2bIz0t3C3LMyeNarGvUFsgaH+j4Ve
         wT0rueuRVCToa67wHNfN8I/fnu5NcV1lKgxlU7/rCBDVa9I+y6ItB163veRU9/MBuX
         05HSSdWufvcjiNmNN534Mr1D/y+LCyK5JDSufkwY=
Date:   Mon, 5 Aug 2019 17:56:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Luwei Kang <luwei.kang@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v4 11/12] fpga: dfl: fme: add global error reporting
 support
Message-ID: <20190805155626.GD8107@kroah.com>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-12-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564914022-3710-12-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 04, 2019 at 06:20:21PM +0800, Wu Hao wrote:
> +static int fme_global_err_init(struct platform_device *pdev,
> +			       struct dfl_feature *feature)
> +{
> +	struct device *dev;
> +	int ret = 0;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->parent = &pdev->dev;
> +	dev->release = err_dev_release;
> +	dev_set_name(dev, "errors");
> +
> +	fme_error_enable(feature);
> +
> +	ret = device_register(dev);
> +	if (ret) {
> +		put_device(dev);
> +		return ret;
> +	}
> +
> +	ret = device_add_groups(dev, error_groups);

cute, but no, you do not create a whole struct device for a subdir.  Use
the attribute group name like you did on earlier patches.

And again, you raced userspace and lost :(

thanks,

greg k-h
