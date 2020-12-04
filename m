Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BEC2CF500
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Dec 2020 20:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgLDTqx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Dec 2020 14:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLDTqx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 4 Dec 2020 14:46:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902EBC061A53;
        Fri,  4 Dec 2020 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Vkil0UnPQDIM57Rw2A4N2DkbAXZzu/WwnO6NpbBwkzg=; b=JYGpuyCpVSGtp5PvCzxmCYTxYN
        ks194ZDBl1cKghuevUleHBMkXpmbNi1OkL8IZBdB2Qq52HFNzZFhFlWBVVSimcm3dz9utoiKtO8Cj
        w13VjZWYzM076lFApzQhvPOmitoF/k4CVwEV3zpvvigZOT8yuW6Z+XqR5ZYou3mVFe9I2ZqcZwEkG
        HKI+mnNlzVAKutTm8VIT74go2HsJZ16Zfn6HhCovdjt5vd5r6PKlTfIQtIQsaNOOWkRsKyXFAgwCK
        OJtJzd/MMXc0so8bwmftcSTCsc1ALF80PdWtlbUicOd4n9mt0TR0lYq5UnSEizKpe0yY3f4kBTriv
        rI8XyuDQ==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klH1j-0003Pp-7w; Fri, 04 Dec 2020 19:45:59 +0000
Subject: Re: [PATCH v7 1/7] fpga: sec-mgr: fpga security manager class driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201203210958.241329-1-russell.h.weight@intel.com>
 <20201203210958.241329-2-russell.h.weight@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <711e290a-d8de-b31a-d640-df6785a3eba3@infradead.org>
Date:   Fri, 4 Dec 2020 11:45:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203210958.241329-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi--

On 12/3/20 1:09 PM, Russ Weight wrote:

> ---

> diff --git a/Documentation/fpga/fpga-sec-mgr.rst b/Documentation/fpga/fpga-sec-mgr.rst
> new file mode 100644
> index 000000000000..26dac599ead7
> --- /dev/null
> +++ b/Documentation/fpga/fpga-sec-mgr.rst
> @@ -0,0 +1,44 @@


> +In addition to managing secure updates of the FPGA and BMC images,
> +the FPGA Security Manager update process may also used to

                                            may also be used to

> +program root entry hashes and cancellation keys for the FPGA static
> +region, the FPGA partial reconfiguration region, and the BMC.


thanks.
-- 
~Randy

