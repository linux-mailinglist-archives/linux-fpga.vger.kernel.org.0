Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19C4648CAE
	for <lists+linux-fpga@lfdr.de>; Sat, 10 Dec 2022 04:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLJDRU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Dec 2022 22:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJDRS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Dec 2022 22:17:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEBE31375;
        Fri,  9 Dec 2022 19:17:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fy4so6412106pjb.0;
        Fri, 09 Dec 2022 19:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfcCAQaJ3kmduYpB+rQFe6/68zr6eEOSwUILoiuNatw=;
        b=Xjq6quRw4g+29K0K78R7a4vLy44NwsFzw6TZSBK9OCfyQRx170exAX73wg3cm/uuov
         FUNCfoF7IoEw4A3AxQw4s1uQRQKazTCWKnmF5OKGZeUPM9/2g2OUedRJA8GXMHgHM4CT
         i0dfazNwsh7gDUk9x6QaOiQJgvk5FzoMdL7Ip9pFZKB5qfm/Hed02yyChkZGhjGy5Oes
         PyrOqjq0FDGq876qkkckC5sOykLxGzUeGJOXzxeqrNVk8LcPvqM32orucn//1F4xOZW6
         n9i7dY4kyyRFelPJo4Jkmth/Yx3CHpunRMRgIkAmOasILtalMGeWBLwvdkQpjQK2S5pp
         AI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfcCAQaJ3kmduYpB+rQFe6/68zr6eEOSwUILoiuNatw=;
        b=oVnCNFfnxzKcQtN3k0aExCkFjxA4CCrLwWW2auMA6FiLM2LiEAPMe0o6EdkWSx2+AP
         TnjAWtciGsjnqR55mcCTAHSA3I90KdGfEplesAszecJhlhoX0TiBNdfsaqSS14LaIP25
         T+uhLmnwRf2OsAikJZtaQBjVwFcgf7KQPtKEhDcYY07iJVM2Zhg26+kzFvkrikOmKWZs
         X4APWIj53iXKtXQL4OIlGWFRcugK4EGT3tM3/AC66vLHNmqUBtkpaMF/E+91YqxfsAKV
         a9NzZdk0x79y2aNMVdZNyI9GpbQjsWBiGDr1m1ApkHqGl/AfitDrpKcf4zdzoF9Gnl4m
         cejA==
X-Gm-Message-State: ANoB5pnArcc0gBNRkZ8WsAnQOnK5kiRG9RsbAUo9G2bN/7Izd+I6bZDW
        TT/Nv/X+0YhvcyxFWJ8u0RIijl+K678=
X-Google-Smtp-Source: AA0mqf6ojaModjo5JyfiHSc0P0dszlj8oHPmvLBUk1QMqMk0FkyE1RFBGz4RkV0BJXKBL+JL48Vytg==
X-Received: by 2002:a17:902:f647:b0:189:101d:9bad with SMTP id m7-20020a170902f64700b00189101d9badmr9451391plg.59.1670642235205;
        Fri, 09 Dec 2022 19:17:15 -0800 (PST)
Received: from debian.me (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b0018982bf03b4sm1970629pld.117.2022.12.09.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 19:17:14 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 241A3103E00; Sat, 10 Dec 2022 10:17:10 +0700 (WIB)
Date:   Sat, 10 Dec 2022 10:17:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v6 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
Message-ID: <Y5P6NjDxy/S7nlF7@debian.me>
References: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com>
 <20221209214523.3484193-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlPKI/korhvKEuYx"
Content-Disposition: inline
In-Reply-To: <20221209214523.3484193-2-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--HlPKI/korhvKEuYx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 01:45:20PM -0800, matthew.gerlach@linux.intel.com w=
rote:
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..606b4b070c33 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -561,6 +561,109 @@ new DFL feature via UIO direct access, its feature =
id should be added to the
>  driver's id_table.
> =20
> =20
> +Device Feature Header - Version 0
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Version 0 (DFHv0) is the original version of the Device Feature Header.
> +The format of DFHv0 is shown below::
> +
> +    +-------------------------------------------------------------------=
----+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 =
ID 0| 0x00
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_L                          =
   0| 0x08
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_H                          =
   0| 0x10
> +    +-------------------------------------------------------------------=
----+
> +
> +- Offset 0x00
> +
> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
> +  * DFH VER - The version of the DFH.
> +  * Rsvd - Currently unused.
> +  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
> +  * Next - The offset of the next DFH in the DFL from the start of the D=
FH. If EOL is set, Next is the size of MMIO ofthe last feature in the list.
> +  * ID - The ID of the feature if Type is private feature.
> +
> +- Offset 0x08
> +
> +  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Iden=
tifier (present only if Type is FME or AFU).
> +
> +- Offset 0x10
> +
> +  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Ident=
ifier (present only if Type is FME or AFU).
> +
> +
> +Device Feature Header - Version 1
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Version 1 (DFHv1) of the Device Feature Header adds the following functi=
onality:
> +
> +* Provides a standardized mechanism for features to describe parameters/=
capabilities to software.
> +* Standardize the use of a GUID for all DFHv1 types.
> +* Decouples the location of the DFH from the register space of the featu=
re itself.
> +
> +The format of Version 1 of the Device Feature Header (DFH) is shown belo=
w::
> +
> +    +-------------------------------------------------------------------=
----+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 =
ID 0| 0x00
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_L                          =
   0| 0x08
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_H                          =
   0| 0x10
> +    +-------------------------------------------------------------------=
----+
> +    |63                   Reg Address/Offset                      1|  Re=
l  0| 0x18
> +    +-------------------------------------------------------------------=
----+
> +    |63        Reg Size       32|Params 31|30 Group    16|15 Instance   =
   0| 0x20
> +    +-------------------------------------------------------------------=
----+
> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID        =
   0| 0x28
> +    +-------------------------------------------------------------------=
----+
> +    |63                 Parameter Data                                  =
   0| 0x30
> +    +-------------------------------------------------------------------=
----+
> +
> +                                  ...
> +
> +    +-------------------------------------------------------------------=
----+
> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID        =
   0|
> +    +-------------------------------------------------------------------=
----+
> +    |63                 Parameter Data                                  =
   0|
> +    +-------------------------------------------------------------------=
----+
> +
> +- Offset 0x00
> +
> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
> +  * DFH VER - The version of the DFH.
> +  * Rsvd - Currently unused.
> +  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
> +  * Next - The offset of the next DFH in the DFL from the start of the D=
FH.
> +  * ID - The ID of the feature if Type is private feature.
> +
> +- Offset 0x08
> +
> +  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Iden=
tifier.
> +
> +- Offset 0x10
> +
> +  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Ident=
ifier.
> +
> +- Offset 0x18
> +
> +  * Reg Address/Offset - If Rel bit is set, then the value is the high 6=
3 bits of a 16 bit aligned absolute address of the feature's registers. If =
Rel bit is clear, then the value is the offset from the start of the DFH of=
 the feature's registers.
> +
> +- Offset 0x20
> +
> +  * Reg Size - Size of feature's register set in bytes.
> +  * Params - Set if DFH has a list of parameter blocks.
> +  * Group - Id of group if feature is part of a group.
> +  * Instance - Id of instance of feature within a group.
> +
> +- Offset 0x28 if feature has parameters
> +
> +  * Next - Offset to the next parameter block in 8 byte words. If EOP se=
t, size in 8 byte words of last parameter.
> +  * Param Version - Version of Param ID.
> +  * Param ID - ID of parameter.
> +
> +- Offset 0x30
> +
> +  * Parameter Data - Parameter data whose size and format is defined by =
version and ID of the parameter.
> +
>  Open discussion
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfig=
uration

What about this wording below (including fitting the prose within 80 column=
s)?

---- >8 ----
diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 606b4b070c3321..3d8f8dde6021db 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -579,26 +579,30 @@ The format of DFHv0 is shown below::
   * Type - The type of DFH (e.g. FME, AFU, or private feature).
   * DFH VER - The version of the DFH.
   * Rsvd - Currently unused.
-  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
-  * Next - The offset of the next DFH in the DFL from the start of the DFH=
=2E If EOL is set, Next is the size of MMIO ofthe last feature in the list.
-  * ID - The ID of the feature if Type is private feature.
+  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
+  * Next - The offset of the next DFH in the DFL from the DFH start. If EO=
L is
+    set, Next is the size of MMIO of the last feature in the list.
+  * ID - The feature ID if Type is private feature.
=20
 - Offset 0x08
=20
-  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identi=
fier (present only if Type is FME or AFU).
+  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identi=
fier
+    (present only if Type is FME or AFU).
=20
 - Offset 0x10
=20
-  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identif=
ier (present only if Type is FME or AFU).
+  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identif=
ier
+    (present only if Type is FME or AFU).
=20
=20
 Device Feature Header - Version 1
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Version 1 (DFHv1) of the Device Feature Header adds the following function=
ality:
=20
-* Provides a standardized mechanism for features to describe parameters/ca=
pabilities to software.
+* Provides a standardized mechanism for features to describe
+  parameters/capabilities to software.
 * Standardize the use of a GUID for all DFHv1 types.
-* Decouples the location of the DFH from the register space of the feature=
 itself.
+* Decouples the DFH location from the register space of the feature itself.
=20
 The format of Version 1 of the Device Feature Header (DFH) is shown below::
=20
@@ -631,38 +635,43 @@ The format of Version 1 of the Device Feature Header =
(DFH) is shown below::
   * Type - The type of DFH (e.g. FME, AFU, or private feature).
   * DFH VER - The version of the DFH.
   * Rsvd - Currently unused.
-  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
-  * Next - The offset of the next DFH in the DFL from the start of the DFH.
-  * ID - The ID of the feature if Type is private feature.
+  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
+  * Next - The offset of the next DFH in the DFL from the DFH start.
+  * ID - The feature ID if Type is private feature.
=20
 - Offset 0x08
=20
-  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identi=
fier.
+  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identi=
fier.
=20
 - Offset 0x10
=20
-  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identif=
ier.
+  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identif=
ier.
=20
 - Offset 0x18
=20
-  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 =
bits of a 16 bit aligned absolute address of the feature's registers. If Re=
l bit is clear, then the value is the offset from the start of the DFH of t=
he feature's registers.
+  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 =
bits
+    of a 16-bit aligned absolute address of the feature's registers. Other=
wise
+    the value is the offset from the start of the DFH of the feature's
+    registers.
=20
 - Offset 0x20
=20
   * Reg Size - Size of feature's register set in bytes.
   * Params - Set if DFH has a list of parameter blocks.
-  * Group - Id of group if feature is part of a group.
-  * Instance - Id of instance of feature within a group.
+  * Group - ID of group if feature is part of a group.
+  * Instance - ID of feature instance within a group.
=20
 - Offset 0x28 if feature has parameters
=20
-  * Next - Offset to the next parameter block in 8 byte words. If EOP set,=
 size in 8 byte words of last parameter.
+  * Next - Offset to the next parameter block in 8 byte words. If EOP set,
+    the value is size in 8 byte words of last parameter.
   * Param Version - Version of Param ID.
   * Param ID - ID of parameter.
=20
 - Offset 0x30
=20
-  * Parameter Data - Parameter data whose size and format is defined by ve=
rsion and ID of the parameter.
+  * Parameter Data - Parameter data whose size and format is defined by
+    version and ID of the parameter.
=20
 Open discussion
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--HlPKI/korhvKEuYx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5P6LAAKCRD2uYlJVVFO
o85tAQCQ/X7C1BEESFknhpc4XhzPdvuzYCUGCrYY8DoHuUzFcwEApc18F0w7QxFL
9q1TeTSERdjvegYjcO0UIpLDCmSE2Qc=
=0Q96
-----END PGP SIGNATURE-----

--HlPKI/korhvKEuYx--
