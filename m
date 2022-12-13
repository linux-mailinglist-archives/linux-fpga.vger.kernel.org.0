Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0417B64AF6F
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 06:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiLMFrf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 00:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiLMFre (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 00:47:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBC18E08;
        Mon, 12 Dec 2022 21:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670910454; x=1702446454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6EB7Bi7g6h+WwBvEMhQIZpLI/dHhIiBPPxI1Y0FWFAI=;
  b=f9bQZQqZqfiNF7i3pgk9iK6s1hqG2VS0J9qHo2lpE5IIurjw6gH68UvE
   SIrM1CtLax19dZ8A+QT/LB+t/+wTUzniQPG2imND74GfRKvbFjUbZnPFf
   F/iE7W8zx6vT9JPWPR+IWs+VMUiczrhkQyqnDHMgsvIJli1EGZGxah1+G
   6X/tqlRFnDk99rPvESoxl0adcw2qtNJNIRHTRusHPiXTvwTXvmymB+Tpg
   P96pECwmMsC2jQw7JHTmjekPq3kgtA2h8xskhKJg/DZHH6wIM4DbGql6I
   IBiv7/fbRy4VAHrMKRn6NG5NDwfQ1qYpb9ySehZVH60YcKBLhDLO9EmSm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="297728259"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="297728259"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="641990832"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="641990832"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2022 21:46:56 -0800
Date:   Tue, 13 Dec 2022 13:37:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 3/8] mfd: intel-m10-bmc: Split into core and spi
 specific parts
Message-ID: <Y5gPgXFM24klp/4Q@yilunxu-OptiPlex-7050>
References: <20221211103913.5287-1-ilpo.jarvinen@linux.intel.com>
 <20221211103913.5287-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211103913.5287-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-11 at 12:39:08 +0200, Ilpo Järvinen wrote:
> Split the common code from intel-m10-bmc driver into intel-m10-bmc-core
> and move the SPI bus parts into an interface specific file.
> 
> intel-m10-bmc-core becomes the core MFD functions which can support
> multiple bus interface like SPI bus.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net> # hwmon
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
