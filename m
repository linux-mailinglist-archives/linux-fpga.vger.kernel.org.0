Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1F3A10AC
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhFIJ52 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 05:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235515AbhFIJ51 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 05:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB66C61375;
        Wed,  9 Jun 2021 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623232532;
        bh=AC6NyNg2hyJCVW5IBQpa7LmxppI5gryhhJfVgsyhhXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMWV3N6dDwpao4AUOl4DcC1TlBSB2VPg+FEse277SA1Tp6H7dQtc7I4OdCkn3XSey
         euJ3J0IqAa7ByQch9TlCEyz0fCbZ/C6Jwy5h+pcPd9v2+cabQnjTi809hEcL9yiikI
         j8wAAUDQbcGnu5B0wEFyXeAXsL//jAe5FT0/C+lc=
Date:   Wed, 9 Jun 2021 11:55:29 +0200
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
Subject: Re: [RFC v2 0/4]Fpga: adds support to load the user-key encrypted
 FPGA Image loading
Message-ID: <YMCQESaESBSKCTrv@kroah.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609055232.4501-1-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 11:22:28AM +0530, Nava kishore Manne wrote:
> This patch series adds supports user-key encrypted FPGA Image loading using
> FPGA Manager framework.

Why is this series "RFC"?  Do you not think it is good enough to be
merged?

thanks,

greg k-h
