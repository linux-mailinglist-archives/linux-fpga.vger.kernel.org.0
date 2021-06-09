Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19783A10A8
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhFIJ5J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 05:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234582AbhFIJ5I (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 05:57:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BA3461042;
        Wed,  9 Jun 2021 09:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623232514;
        bh=JrqycFn4TkpeNt54gU7cj38GFkWwPD/eocl+1ViKwdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v4GVOZz7LUNMpiL/jfSpVpx8PplMlVpZDbzqJ3xpuBmuUNoKEUfFrUTQBxqajo2vI
         Gl3DZckysR2NIvdDJN6kvQ9iwqU9r+DaOacvxFVqWmC0qHVPCghK4g+hXJcEhOtCX0
         gXPsxBm2lJUMSfeQquMVhqGKG25G55ZM2n7rzt9M=
Date:   Wed, 9 Jun 2021 11:55:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com, mdf@kernel.org,
        trix@redhat.com, arnd@arndb.de, rajan.vaja@xilinx.com,
        amit.sunil.dhamne@xilinx.com, tejas.patel@xilinx.com,
        zou_wei@huawei.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        ravi.patel@xilinx.com, iwamatsu@nigauri.org,
        wendy.liang@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
Subject: Re: [RFC v2 1/4] drivers: firmware: Add user encrypted key load API
 support
Message-ID: <YMCP/+uYMun478Z9@kroah.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
 <20210609055232.4501-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609055232.4501-2-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 11:22:29AM +0530, Nava kishore Manne wrote:
> This patch adds user encrypted key load API to support
> User key encrypted images loading use cases from Linux.

What is "user key encrypted images"?  Do we need more documentation here
for what this is and how to use it?

And why is "User" capitalized?

thanks,

greg k-h
