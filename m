Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C523AAE52
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Jun 2021 10:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFQIDp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Jun 2021 04:03:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50730 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhFQIDb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Jun 2021 04:03:31 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ltmxT-0003hK-78; Thu, 17 Jun 2021 16:01:03 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ltmx9-0002mO-VK; Thu, 17 Jun 2021 16:00:43 +0800
Date:   Thu, 17 Jun 2021 16:00:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     trix@redhat.com
Cc:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Sven.Auhagen@voleatech.de, grandmaster@al2klimov.de,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 04/11] crypto: marvell: cesa: change FPGA indirect
 article to an
Message-ID: <20210617080043.GA10662@gondor.apana.org.au>
References: <20210608212350.3029742-1-trix@redhat.com>
 <20210608212350.3029742-6-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608212350.3029742-6-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 08, 2021 at 02:23:43PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Change use of 'a fpga' to 'an fpga'
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/crypto/marvell/cesa/cesa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
