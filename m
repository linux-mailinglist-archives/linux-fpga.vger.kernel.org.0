Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C76305163
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 05:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhA0Ep2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 23:45:28 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:35881 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730886AbhAZFEu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Jan 2021 00:04:50 -0500
Received: by mail-pl1-f174.google.com with SMTP id e9so9179637plh.3;
        Mon, 25 Jan 2021 21:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZIbd3jXt6ht4gWlxlhO6dvETRinbduf9IxOiI+0CKo=;
        b=RBv5nhp84WvvX/zicTXtZcf8NLTwf8JjiEP/NJHCnpsJtp7Y+VzfVNKbHKgaW9KbPU
         rdAtEsRHKJ4giCLRKBsVTO0Nq4HwHivGfIN0zDoWYIYMXYsjWgTnZnzPJE+7zv4fJJfl
         vuXV9uo8ZVne/Gb8e64Z+SCLDw9rnNOVoSD2xYYabc0t7ctRpE0pqgWZcQGPd3CFFg2w
         JPXYf9wD6I2N/FjPefQpGtWQjh/O7FQQRClagzvIUeM4NxHWld9UX0vk+wviAOxYG8eX
         UxFOxk0h8LoNH0eik0713V/JbOD4fUYT6+gLrRdlprUmcarYEENpEkGJBBndpWmV3Jwb
         Q/qw==
X-Gm-Message-State: AOAM5334UCsk9CycXdda8dJVOZAPI/eJl6NF6XirJ78r4p3K3OuR4K6q
        Aij+5zkuGUJVzfucy9v2U2TA064Sh3E=
X-Google-Smtp-Source: ABdhPJxYt0aK40JvksG7aYPrXgBqlsqlhnLexevNOdQWD+DO9/BfDTAjAGLQFo7TcOtTUd8I0V1RkA==
X-Received: by 2002:a17:902:bd0a:b029:e0:612:ad38 with SMTP id p10-20020a170902bd0ab02900e00612ad38mr4427903pls.30.1611637450430;
        Mon, 25 Jan 2021 21:04:10 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s4sm888701pji.34.2021.01.25.21.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:04:09 -0800 (PST)
Date:   Mon, 25 Jan 2021 21:04:08 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 3/6] fpga: fpga-mgr: add
 FPGA_MGR_BITSTREM_AUTHENTICATION flag
Message-ID: <YA+iyFi4lQWPgkTQ@epycbox.lan>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611608188-25621-4-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 25, 2021 at 02:56:25PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add FPGA_MGR_BITSTREM_AUTHENTICATION flag for FPGA bitstream
> authentication, which makes sure a signed bitstream has valid signatures.
> 
> Except for the actual configuration of the device, the authentication works
> the same way as FPGA configuration does. If the authentication passes, the
> bitstream will be programmed into QSPI flash and will be expected to boot
> without issues.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: no change
> v2: align all FPGA_MGR_* flags
>     update the commit messages
> ---
>  include/linux/fpga/fpga-mgr.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 2bc3030..4fb3400 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -67,12 +67,15 @@ enum fpga_mgr_states {
>   * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
>   *
>   * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> + *
> + * %FPGA_MGR_BITSTREM_AUTHENTICATION: do FPGA bitstream authentication only
>   */
> -#define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
> -#define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
> -#define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
> -#define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
> -#define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
> +#define FPGA_MGR_PARTIAL_RECONFIG		BIT(0)
> +#define FPGA_MGR_EXTERNAL_CONFIG		BIT(1)
> +#define FPGA_MGR_ENCRYPTED_BITSTREAM		BIT(2)
> +#define FPGA_MGR_BITSTREAM_LSB_FIRST		BIT(3)
> +#define FPGA_MGR_COMPRESSED_BITSTREAM		BIT(4)
> +#define FPGA_MGR_BITSTREM_AUTHENTICATION	BIT(5)
Consider FPGA_MGR_BITSTREAM_AUTHENTICATE (and fix typo)
>  
>  /**
>   * struct fpga_image_info - information specific to a FPGA image
> -- 
> 2.7.4
> 

Thanks,
Moritz
