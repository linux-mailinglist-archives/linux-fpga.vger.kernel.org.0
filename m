Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718EE60390F
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Oct 2022 07:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiJSFD2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 Oct 2022 01:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJSFD2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 19 Oct 2022 01:03:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7619A5D101;
        Tue, 18 Oct 2022 22:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666155807; x=1697691807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o6pyxH0L5HFS1fwpUgdGvaHH+ef6BU4LBn8UIWF6hk4=;
  b=fGmz52n6vpoBHv4F1EbbqdwkBdG12cxv19J5lQmHhd5YdK7jdH9qA/Ra
   BG/Si26HM3xz3LgesiKfEez2l6E+B2gcpyGIluqXoeW81McTJOIsr9oro
   JNNgU4uAXXE++XC7frdDAIMyRtqbNAA5QyavkV6gtvs+NhOUG6oIO7ITR
   wH9FKkO+xdDvhS4XdUxUcTTa6Dm8+xdnrqli1ItQHElPiag/kEZ5m4+i4
   q4lq323oA8sEtPBjnETcRgH3auvJICTJ5d4l0hDqDKHCcIWic6j/QoeQL
   oQ3XUlAyVONYOq6WhOTtkjz69Ti8U6cB1/17ZlAhs08CrEior0+h1baxQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="289624353"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="289624353"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 22:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771583163"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="771583163"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 22:03:23 -0700
Date:   Wed, 19 Oct 2022 12:54:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v18 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Y0+C9tTIXkAcKXBS@yilunxu-OptiPlex-7050>
References: <20221014202750.20542-1-i.bornyakov@metrotek.ru>
 <20221014202750.20542-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014202750.20542-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-14 at 23:27:49 +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI sysCONFIG interface.
> 
> sysCONFIG interface core functionality is separate from both ECP5 and
> SPI specifics, so support for other FPGAs with different port types can
> be added in the future.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---

[...]

> +static int sysconfig_poll_gpio(struct gpio_desc *gpio, bool is_active)
> +{
> +	int ret, val;
> +
> +	ret = read_poll_timeout(gpiod_get_value, val, val < 0 ||
> +				(val && is_active) || (!val && !is_active),

val < 0 || (!!val == is_active)

is it better?

> +				SYSCONFIG_POLL_INTERVAL_US,
> +				SYSCONFIG_POLL_GPIO_TIMEOUT_US, false, gpio);
> +
> +	return val < 0 ? val : ret;

Try not to use ternery operator here.

  if (ret)
	return ret;
  else if (val < 0)
	return val;

  return 0;

Is it OK?

Thanks,
Yilun
