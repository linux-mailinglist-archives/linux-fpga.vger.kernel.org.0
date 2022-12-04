Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E41641C37
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Dec 2022 10:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLDJoi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Dec 2022 04:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiLDJoe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Dec 2022 04:44:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845BF186C7;
        Sun,  4 Dec 2022 01:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20058B80813;
        Sun,  4 Dec 2022 09:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB880C433D6;
        Sun,  4 Dec 2022 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670147070;
        bh=EZT67/m18c2otgDWsLEQDZEinTscEZxP03Tjfwybbwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7CwKuivyjZxBtQjwQjV5P8lpVHTFhVHSNJTM+YygtEIEVEKZN6MKZc2Na3lYojPJ
         9tkVZReH+dcMCgxgv3lvmKOwVoPY2wiV6d9V/HIBSoiyOfZFF+PEy+o+S6Sib5o/nb
         ONieB93kYA7A96zGIkn8J7XdyrwLY017s8hsYyrg=
Date:   Sun, 4 Dec 2022 10:44:26 +0100
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
Subject: Re: [PATCH v3 9/9] mfd: intel-m10-bmc: Change MODULE_LICENSE() to GPL
Message-ID: <Y4xr+nmx7m66+KsL@kroah.com>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-10-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202100841.4741-10-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Dec 02, 2022 at 12:08:41PM +0200, Ilpo Järvinen wrote:
> "GPL v2" should not be used as MODULE_LICENSE(). "GPL" is enough, see
> commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL
> v2" bogosity") for more details.

And that commit says that leaving "GPL v2" is just fine and dandy and
should not be an issue at all.

Please do not change the license for no good reason.  That commit is NOT
a good reason to change it at all.

so NAK on this patch, sorry.

greg k-h
