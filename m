Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4852D9965
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgLNOEu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 09:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgLNOEm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:04:42 -0500
Date:   Mon, 14 Dec 2020 15:05:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607954642;
        bh=pbAlBhkc+GZ/LGXPR0Am14zRFMSLBreyopfAnyP9OJ4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUtsJrmQFy3I4woeTIdECaPib8kf9ozb0GosKP87sA4Q/j5sLOi07MwGgRSBTUXVc
         BNEHZCn3P7uyo+4A7jWrdpJ0LNtDUCWPD5290JlJx5m2fGGgvJQ0Hfh15lPo9a9lHI
         N5A2Rjk+3txpFGA1RD9j3ZxzPswGSimVkHliqfgY=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, richard.gong@intel.com
Subject: Re: [PATCHv2 0/5] Extend Intel service layer, FPGA manager and region
Message-ID: <X9dxE/jQ33mfWBz/@kroah.com>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
 <8640e59d-5e38-a32a-2ac6-a178180e816d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8640e59d-5e38-a32a-2ac6-a178180e816d@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 14, 2020 at 08:03:07AM -0600, Richard Gong wrote:
> 
> Hi Moritz, Greg,
> 
> Sorry for asking.
> 
> Any comment on Intel service layer and FPGA patches submitted on 11/18/20?

I don't see them in my review queue, sorry.

greg k-h
