Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3D6305AD7
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhA0MHH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 07:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237477AbhA0MFi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Jan 2021 07:05:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12BD420780;
        Wed, 27 Jan 2021 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611749097;
        bh=yTmGQ0DVnvKLau7tig8myya+Wgj/1YA3iyYkOFhac4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvvVUu2qRmQyYXd1/HWhxJjQMiHV7QRrST1dY4bSA+zoeWEfbDUCc7nSreQjncaWh
         HDoY9lJQfJ7VZSf2ut5MQTzKLnUqqlAQPeHgfZPlsLjO8UARzQhtpdvRxZlm32NKwd
         dJV2rFyTNEQA/mlqcx8oMSyC6owhW3NeBbJ0t8gE=
Date:   Wed, 27 Jan 2021 13:04:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 1/6] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
Message-ID: <YBFW50LPP/yEbvEW@kroah.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 25, 2021 at 02:56:23PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
> authentication feature. Authenticating a bitstream is to make sure a signed
> bitstream has the valid signatures.
> 
> Except for the actual configuration of the device, the bitstream
> authentication works the same way as FPGA configuration does. If the
> authentication passes, the signed bitstream will be programmed into QSPI
> flash memory and will be expected to boot without issues.
> 
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: no change
> v2: new added
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index ebc2956..7ada1f2 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -51,12 +51,17 @@
>  #define SVC_STATUS_NO_SUPPORT		6
>  
>  /*
> - * Flag bit for COMMAND_RECONFIG
> + * Flag for COMMAND_RECONFIG, in bit number
>   *
>   * COMMAND_RECONFIG_FLAG_PARTIAL:
> - * Set to FPGA configuration type (full or partial).
> + * Set for partial FPGA configuration.
> + *
> + * COMMAND_AUTHENTICATE_BITSTREAM:
> + * Set for bitstream authentication, which makes sure a signed bitstream
> + * has valid signatures before committing it to QSPI flash memory.
>   */
> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0

So is this a bugfix, changing this value to the correct one?

If so, shouldn't this be a stand-alone patch and get backported to
stable kernel releases?

If not, then no one uses this flag today?

thanks,

greg k-h
