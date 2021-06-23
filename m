Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6503B171F
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFWJqq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJqq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Jun 2021 05:46:46 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE849C061574
        for <linux-fpga@vger.kernel.org>; Wed, 23 Jun 2021 02:44:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e22so1290097pgv.10
        for <linux-fpga@vger.kernel.org>; Wed, 23 Jun 2021 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=10C48RMzz/B/GLndTETJnJTORiP2gVzYgTK4Oh6GMnk=;
        b=GNOksuA/zRnhl/pAKoWm/O5HjiahS6GnmYsw41BrGUibjYlFQMWTnKDy4ecQ67cDL5
         IYy4DgIYNsVftnoVi9Gqft81earpiGrAqS5DI6fjV+s0LJAeQ31ALwBSuoCr1ED3l9Kt
         JEsfgwwTxXYBL4oTVCRd3PdN40jlVAwUAiSCCrY7Lt0e1y2kQsB/9JZluOp1FbHx/Lzz
         5K6DaAb6YcyVY2C3Tr/N7MFpCXQZ9fh5senlTZnzVr2DztPtZ90n/Itw39O+9b3cn2fF
         WgknCcDsPgCUVjAGa8Xb5v39H688H/o/Wgabujtniqfud4TqW6K2suqZyFd4PseDGmxV
         OxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=10C48RMzz/B/GLndTETJnJTORiP2gVzYgTK4Oh6GMnk=;
        b=Gq2ZSg3AoyOhcgYUOxzCANBvJ6wjfEWVnc2joTcHKtGPEypGOMEY+0NnEVwwfEo3QU
         6NcHMGONGghf9fdKtIQYHtHEPC+ZYky/uZeQ3Hwqe5Cgu3SRP36y+hGnSX+R69uVQ2fg
         vVLwLNqn7gxRdLoLMf/KoGog5FxiBOOR20TlaQSYdVAaZPnLEL0j/OtSA8SSiARMYQVO
         6v0hbaz96oYsVkXWgMGGudqLgv7uBJurNQhXpC5gKEBU2/NE2t8OWFaiIqbSIWrlG9+T
         pzuwWN4enbysmh6REqipNU6l2aiP5pwB+dOLy+O392dpILDPCIWpiq6Vflt3jUnYsy5o
         u/JQ==
X-Gm-Message-State: AOAM533gsTk4GXq/FRH26T/lmQCTBxoQoI31ZnHpsKPOAPa8vqeXrTvK
        8RDhTKWUF708qTCl+GLenUTiHcXUlbajdkFy5hODnmo4
X-Google-Smtp-Source: ABdhPJwmfNtMLyIgQ/ay3zhscL9fpT6FD5U8hvwEbF7oDST8GQUXm0h+lBEqjUsbOea5L8Sz4GVQT9k4Z4r9I5BC+es=
X-Received: by 2002:a05:6a00:158a:b029:306:c1e4:ca5e with SMTP id
 u10-20020a056a00158ab0290306c1e4ca5emr2259524pfk.24.1624441468554; Wed, 23
 Jun 2021 02:44:28 -0700 (PDT)
MIME-Version: 1.0
From:   Goran Broeckaert <broeckaert.goran@gmail.com>
Date:   Wed, 23 Jun 2021 11:44:17 +0200
Message-ID: <CANq43+G6CUrcEn30Erf1iTLSq+kzVsAvWrjeJU_n9ZiwhLkfQQ@mail.gmail.com>
Subject: [Question] machxo2-spi driver input file
To:     linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I'm using this driver to program the machxo2 over SPI. But after
searching in the datasheet and documentation, I haven't been able to
find what file the driver is expecting.

Kind regards,
Goran Broeckaert
