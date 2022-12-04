Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF34C641C3D
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Dec 2022 10:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiLDJp5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Dec 2022 04:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiLDJpV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Dec 2022 04:45:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407C19292;
        Sun,  4 Dec 2022 01:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7013B80918;
        Sun,  4 Dec 2022 09:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01156C433C1;
        Sun,  4 Dec 2022 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670147109;
        bh=ZIllqAdxVokM7EpkZOzNS+Etiii/UCyvAJE1L0DOvDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0lvX9DiFM3rI48N0WZHmlVxDRZlF6jcfcZhsuwuPluMEgZPhH1K5HJZ3wY3+Kde2
         +2pAxbTj8aZJshut+Oq3a+RWb70sDlOH5DyJg5nHZUbuK7hnjWxbKavca3JbHuT6ng
         OIagHpgUDGDOQuwqvv4vLjsiTx7ONcmmh9cXzB+8=
Date:   Sun, 4 Dec 2022 10:45:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] mfd: intel-m10-bmc: Change MODULE_LICENSE() to
 GPL
Message-ID: <Y4xsIvYUSH1jMx2J@kroah.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
 <20221117120515.37807-12-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117120515.37807-12-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Nov 17, 2022 at 02:05:15PM +0200, Ilpo Järvinen wrote:
> "GPL v2" should not be used as MODULE_LICENSE(). "GPL" is enough, see
> commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL
> v2" bogosity") for more details.

Same issue here, this is not needed at all, so please just leave it
alone or people will want to start to send this type of change out for
all old drivers.  That's not needed or wanted by anyone.

thanks,

greg k-h
