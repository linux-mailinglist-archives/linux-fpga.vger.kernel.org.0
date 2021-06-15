Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2083A77F2
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 09:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFOH2s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 03:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhFOH2r (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 03:28:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EF21600CD;
        Tue, 15 Jun 2021 07:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623742003;
        bh=rqLmbBPqLHcQc3DU4JjH/nhDlHNoF6Fp1fM2HpeNIuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qydXXUAchFQHbbbdRulEfZ4gHvrpyVYobxK2XHd133w9a81vrO0QaebBctYsIyEGX
         5/NPumgu+YwI8BozqL8Wb/0hwsptoSFPtX0fbHUljijpC9yCG6DXwt6LqNc4QnkXNW
         UDIzC8lfiDfWyGWXnhKPfHEt2h5FIEg/+0YKqSV4=
Date:   Tue, 15 Jun 2021 09:26:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 7/8] fpga: bridge: Use standard dev_release for class
 driver
Message-ID: <YMhWMP7PYwzxzHUn@kroah.com>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-8-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614170909.232415-8-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 14, 2021 at 10:09:08AM -0700, Moritz Fischer wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> The FPGA bridge class driver data structure is being treated as a managed
> resource instead of using standard dev_release call-back to release the
> class data structure. This change populates the class.dev_release function
> and changes the fpga_bridge_free() function to call put_device(). It also
> changes fpga_bridge_unregister() to call device_del() instead of
> device_unregister().

Same "two step" problem here as the previous patch shows.

And again, why are you having both a create/register process?  Why not
just do it all internally?

thanks,

greg k-h
